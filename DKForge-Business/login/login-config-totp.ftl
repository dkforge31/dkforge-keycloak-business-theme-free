<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>

<@layout.registrationLayout displayRequiredFields=false; section>

    <#if section = "header">
        ${msg("loginTotpTitle")}

    <#elseif section = "form">

        <div class="kc-form-content">
            <h2 class="form-title">${msg("configureTotpTitle")}</h2>

            <ol class="kc-animated-list">
                <li>
                    <p>${msg("loginTotpStep1")}</p>
                    <ul>
                        <#list totp.supportedApplications as app>
                            <li>${msg(app)}</li>
                        </#list>
                    </ul>
                </li>

                <#if mode?? && mode = "manual">
                    <li>
                        <p>${msg("loginTotpManualStep2")}</p>
                        <p class="kc-totp-secret">${totp.totpSecretEncoded}</p>
                        <p class="kc-registration-info"><a href="${totp.qrUrl}" class="kc-link-animated">${msg("loginTotpScanBarcode")}</a></p>
                    </li>

                    <li>
                        <p>${msg("loginTotpManualStep3")}</p>
                        <ul>
                            <li>${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                            <li>${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                            <li>${msg("loginTotpDigits")}: ${totp.policy.digits}</li>

                            <#if totp.policy.type = "totp">
                                <li>${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                            <#else>
                                <li>${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                            </#if>
                        </ul>
                    </li>

                <#else>
                    <li>
                        <p>${msg("loginTotpStep2")}</p>
                        <img id="kc-totp-secret-qr-code"
                             class="kc-qr-animated"
                             src="data:image/png;base64, ${totp.totpSecretQrCode}"
                             alt="QR Code">
                        <p class="kc-registration-info"><a href="${totp.manualUrl}" class="kc-link-animated">${msg("loginTotpUnableToScan")}</a></p>
                    </li>
                </#if>

                <li>
                    <p>${msg("loginTotpStep3")}</p>
                    <p>${msg("loginTotpStep3DeviceName")}</p>
                </li>
            </ol>

            <form action="${url.loginAction}" method="post" class="kc-business-form">

                <!-- AUTHENTICATOR CODE -->
                <div class="kc-form-group">
                    <div class="kc-input-floating">
                        <input
                            id="totp"
                            name="totp"
                            type="text"
                            autocomplete="one-time-code"
                            class="kc-input-business"
                            placeholder=" "
                            aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                            inputmode="numeric"
                            dir="ltr"
                        />
                        <label for="totp" class="kc-label-business">
                            ${msg("authenticatorCode")}
                        </label>
                        <span class="kc-input-border"></span>
                    </div>

                    <#if messagesPerField.existsError('totp')>
                        <span class="kc-error-msg">
                            ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
                        </span>
                    </#if>
                </div>

                <input type="hidden" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" name="mode" value="${mode}"/></#if>

                <!-- DEVICE NAME -->
                <div class="kc-form-group">
                    <div class="kc-input-floating">
                        <input
                            id="userLabel"
                            name="userLabel"
                            type="text"
                            autocomplete="off"
                            class="kc-input-business"
                            placeholder=" "
                            aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                        />
                        <label for="userLabel" class="kc-label-business">
                            ${msg("loginTotpDeviceName")}
                        </label>
                        <span class="kc-input-border"></span>
                    </div>

                    <#if messagesPerField.existsError('userLabel')>
                        <span class="kc-error-msg">
                            ${kcSanitize(messagesPerField.getFirstError('userLabel'))?no_esc}
                        </span>
                    </#if>
                </div>

                <div class="kc-form-group">
                    <@passwordCommons.logoutOtherSessions/>
                </div>

                <button type="submit" class="kc-button-business">
                    ${msg("doSubmit")}
                </button>

            </form>
        </div>

    </#if>

</@layout.registrationLayout>
