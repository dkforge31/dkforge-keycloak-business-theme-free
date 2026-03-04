<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <div class="kc-password-recovery">
            <h2>${msg("emailForgotTitle")}</h2>
            <p>${msg("emailInstruction")}</p>
            
            <form id="kc-reset-password-form" class="kc-form" action="${url.loginAction}" method="post">
                <div class="kc-form-group">
                    <label for="username" class="form-label">${msg("usernameOrEmail")}</label>

                    <input 
                        type="text"
                        id="username"
                        name="username" 
                        value="${(auth.attemptedUsername!'')}"
                        class="kc-input-business"
                        autofocus
                        aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                    />

                    <#if messagesPerField.existsError('username')>
                        <span class="kc-error-msg" aria-live="polite">
                            ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                        </span>
                    </#if>
                </div>

                <button type="submit" class="kc-button-business">${msg("resetPasswordSubmit")}</button>

                <div class="kc-login-prompt">
                    <a href="${url.loginUrl}">${msg("backToLogin")}</a>
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>
