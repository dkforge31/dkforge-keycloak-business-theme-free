// WebAuthn Registration - Native browser APIs only, no external dependencies
export async function registerByWebAuthn(input) {
    // Check if WebAuthn is supported
    if (!window.PublicKeyCredential) {
        returnFailure(input.errmsg);
        return;
    }

    try {
        const challenge = Uint8Array.from(atob(input.challenge.replace(/-/g, '+').replace(/_/g, '/')), c => c.charCodeAt(0));
        const userid = Uint8Array.from(atob(input.userid.replace(/-/g, '+').replace(/_/g, '/')), c => c.charCodeAt(0));

        const publicKey = {
            challenge: challenge,
            rp: {id: input.rpId, name: input.rpEntityName},
            user: {
                id: userid,
                name: input.username,
                displayName: input.username
            },
            pubKeyCredParams: getPubKeyCredParams(input.signatureAlgorithms),
            timeout: input.createTimeout,
            attestation: input.attestationConveyancePreference !== 'not specified' ? input.attestationConveyancePreference : 'none'
        };

        const authenticatorSelection = {};
        let isAuthenticatorSelectionSpecified = false;

        if (input.authenticatorAttachment !== 'not specified') {
            authenticatorSelection.authenticatorAttachment = input.authenticatorAttachment;
            isAuthenticatorSelectionSpecified = true;
        }

        if (input.requireResidentKey !== 'not specified') {
            authenticatorSelection.residentKey = input.requireResidentKey.toLowerCase();
            isAuthenticatorSelectionSpecified = true;
        }

        if (input.userVerificationRequirement !== 'not specified') {
            authenticatorSelection.userVerification = input.userVerificationRequirement;
            isAuthenticatorSelectionSpecified = true;
        }

        if (isAuthenticatorSelectionSpecified) {
            publicKey.authenticatorSelection = authenticatorSelection;
        }

        if (input.excludeCredentialIds) {
            const excludeList = JSON.parse(input.excludeCredentialIds);
            publicKey.excludeCredentials = excludeList.map(id => ({
                type: 'public-key',
                id: Uint8Array.from(atob(id.replace(/-/g, '+').replace(/_/g, '/')), c => c.charCodeAt(0))
            }));
        }

        const credential = await navigator.credentials.create({publicKey});
        
        if (!credential) {
            returnFailure(input.errmsg + ': Registration cancelled');
            return;
        }

        const attestationObject = credential.response.attestationObject;
        const clientDataJSON = credential.response.clientDataJSON;
        const publicKeyCredentialId = credential.id;

        document.getElementById('attestationObject').value = base64url(attestationObject);
        document.getElementById('clientDataJSON').value = base64url(clientDataJSON);
        document.getElementById('publicKeyCredentialId').value = publicKeyCredentialId;

        if (input.authenticatorLabel) {
            const authenticatorLabel = input.authenticatorLabel.trim();
            if (authenticatorLabel.length > 0) {
                document.getElementById('authenticatorLabel').value = authenticatorLabel;
            }
        }

        const transports = credential.response.getTransports ? credential.response.getTransports() : [];
        if (transports.length > 0) {
            document.getElementById('transports').value = JSON.stringify(transports);
        }

        document.getElementById('register').submit();

    } catch (error) {
        console.error('WebAuthn registration error:', error);
        returnFailure(input.errmsg + ': ' + error.message);
    }
}

function getPubKeyCredParams(signatureAlgorithms) {
    const pubKeyCredParams = [];
    for (let i = 0; i < signatureAlgorithms.length; i++) {
        pubKeyCredParams.push({alg: signatureAlgorithms[i], type: 'public-key'});
    }
    return pubKeyCredParams;
}

function base64url(buffer) {
    let binary = '';
    const bytes = new Uint8Array(buffer);
    for (let i = 0; i < bytes.byteLength; i++) {
        binary += String.fromCharCode(bytes[i]);
    }
    return btoa(binary).replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '');
}

function returnFailure(msg) {
    document.getElementById('error').value = msg;
    document.getElementById('register').submit();
}
