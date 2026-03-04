<#import "template.ftl" as layout>
<@layout.registrationLayout; section>

    <#if section="header">
        ${msg("doLogIn")}

    <#elseif section="form">

        <form id="kc-otp-login-form"
              class="kc-business-form"
              onsubmit="login.disabled = true; return true;"
              action="${url.loginAction}"
              method="post">

            <#-- MULTIPLE OTP DEVICES -->
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="kc-business-otp-selector">
                    <#list otpLogin.userOtpCredentials as otpCredential>
                        <div class="kc-business-otp-radio-wrapper">
                            <input id="kc-otp-credential-${otpCredential?index}"
                                   class="kc-business-otp-radio"
                                   type="radio"
                                   name="selectedCredentialId"
                                   value="${otpCredential.id}"
                                   <#if otpCredential.id == otpLogin.selectedCredentialId>checked</#if> />

                            <label for="kc-otp-credential-${otpCredential?index}"
                                   class="kc-business-otp-label">
                                <span><i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i></span>
                                <span>${otpCredential.userLabel}</span>
                            </label>
                        </div>
                    </#list>
                </div>
            </#if>

            <!-- OTP INPUT WITH FLOATING LABEL -->
            <div class="kc-form-group">
                <div class="kc-input-floating">
                    <input id="otp"
                           name="otp"
                           type="text"
                           autocomplete="one-time-code"
                           class="kc-input-business"
                           placeholder=" "
                           autofocus
                           aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                           dir="ltr" />

                    <label for="otp" class="kc-label-business">
                        ${msg("loginOtpOneTime")}
                    </label>

                    <span class="kc-input-border"></span>
                </div>

                <#if messagesPerField.existsError('totp')>
                    <span class="kc-error-msg" aria-live="polite">
                        ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
                    </span>
                </#if>
            </div>

            <!-- SUBMIT BUTTON -->
            <div class="kc-form-group">
                <button class="kc-button-business" id="kc-login" type="submit">
                    ${msg("doLogIn")}
                </button>
            </div>

        </form>

    </#if>

</@layout.registrationLayout>
