<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=(realm.registrationAllowed && !registrationDisabled??); section>

  <#if section = "title">
    ${kcSanitize(msg("webauthn-login-title"))?no_esc}

  <#elseif section = "header">
    ${kcSanitize(msg("webauthn-login-title"))?no_esc}

  <#elseif section = "form">
    <div class="hc-form-wrapper">
      <h2 class="hc-form-title">
        🔐 ${kcSanitize(msg("webauthn-login-title"))?no_esc}
      </h2>

      <div id="kc-form-webauthn" class="hc-form">
        <form id="webauth" action="${url.loginAction}" method="post">
          <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
          <input type="hidden" id="authenticatorData" name="authenticatorData"/>
          <input type="hidden" id="signature" name="signature"/>
          <input type="hidden" id="credentialId" name="credentialId"/>
          <input type="hidden" id="userHandle" name="userHandle"/>
          <input type="hidden" id="error" name="error"/>
        </form>

        <#if authenticators??>
          <form id="authn_select" class="hc-form">
            <#list authenticators.authenticators as authenticator>
              <input type="hidden" name="authn_use_chk" value="${authenticator.credentialId}"/>
            </#list>
          </form>

          <#if shouldDisplayAuthenticators?? && shouldDisplayAuthenticators>
            <#if authenticators.authenticators?size gt 1>
              <p class="hc-authenticators-title">
                ${kcSanitize(msg("webauthn-available-authenticators"))?no_esc}
              </p>
            </#if>

            <div class="hc-authenticators-list">
              <#list authenticators.authenticators as authenticator>
                <div id="kc-webauthn-authenticator-item-${authenticator?index}" class="hc-authenticator-item">
                  <div class="hc-authenticator-body">

                    <div id="kc-webauthn-authenticator-label-${authenticator?index}" class="hc-authenticator-label">
                      ${kcSanitize(authenticator.label)?no_esc}
                    </div>

                    <#if authenticator.transports?? && authenticator.transports.displayNameProperties?has_content>
                      <div id="kc-webauthn-authenticator-transport-${authenticator?index}" class="hc-authenticator-transport">
                        <#list authenticator.transports.displayNameProperties as nameProperty>
                          <span>${kcSanitize(msg('${nameProperty!}'))?no_esc}</span><#if nameProperty?has_next><span>, </span></#if>
                        </#list>
                      </div>
                    </#if>

                    <div class="hc-authenticator-created">
                      <span id="kc-webauthn-authenticator-createdlabel-${authenticator?index}">
                        ${kcSanitize(msg("webauthn-createdAt-label"))?no_esc}:
                      </span>
                      <span id="kc-webauthn-authenticator-created-${authenticator?index}">
                        ${kcSanitize(authenticator.createdAt)?no_esc}
                      </span>
                    </div>

                  </div>
                </div>
              </#list>
            </div>
          </#if>
        </#if>

        <div class="hc-form-buttons">
          <button id="authenticateWebAuthnButton" type="button" autofocus="autofocus" class="hc-button">
            ${kcSanitize(msg("webauthn-doAuthenticate"))?no_esc}
          </button>
        </div>
      </div>
    </div>

    <script type="module">
      import { authenticateByWebAuthn } from "${url.resourcesPath}/js/webauthnAuthenticate.js";
      const authButton = document.getElementById('authenticateWebAuthnButton');
      authButton.addEventListener("click", function() {
        const input = {
          isUserIdentified : ${isUserIdentified},
          challenge : '${challenge}',
          userVerification : '${userVerification}',
          rpId : '${rpId}',
          createTimeout : ${createTimeout?c},
          errmsg : "${msg("webauthn-unsupported-browser-text")?no_esc}"
        };
        authenticateByWebAuthn(input);
      }, { once: true });
    </script>

  <#elseif section = "info">
    <#if realm.registrationAllowed && !registrationDisabled??>
      <div id="kc-registration" class="kc-registration-info">
        ${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("requestAccessLink")}</a>
      </div>
    </#if>

  <#elseif section = "show-username">
  </#if>

</@layout.registrationLayout>