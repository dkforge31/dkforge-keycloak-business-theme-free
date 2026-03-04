<#import "template.ftl" as layout>
<#import "passkeys.ftl" as passkeys>
<@layout.registrationLayout displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div class="kc-login-form-business">
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <#if !usernameHidden??>
                    <div class="kc-form-group">
                        <label for="username">
                            <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                        </label>
                        <input 
                            id="username" 
                            name="username" 
                            value="${(login.username!'')}"  
                            type="text"
                            autofocus 
                            autocomplete="username"
                            class="kc-input-business"
                            aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                            dir="ltr"
                        />
                        <#if messagesPerField.existsError('username')>
                            <span class="kc-error-msg">
                                ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </#if>

                <#if realm.rememberMe && !usernameHidden??>
                    <div class="kc-remember-me">
                        <input type="checkbox" id="rememberMe" name="rememberMe" class="kc-checkbox-business">
                        <label for="rememberMe">${msg("rememberMe")}</label>
                    </div>
                </#if>

                <button type="submit" class="kc-button-business">${msg("doLogIn")}</button>

                <#if realm.resetPasswordAllowed>
                    <div class="kc-password-recovery">
                        <a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                    </div>
                </#if>

                <#if realm.registrationAllowed && !registrationDisabled??>
                    <div class="kc-registration-info">
                        ${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a>
                    </div>
                </#if>
            </form>
        </div>
        <@passkeys.conditionalUIData />

    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers?has_content>
            <div class="kc-social-section">
                <p class="kc-divider-text">${msg("orConnectWith")}</p>
                <div class="kc-social-buttons">
                    <#list social.providers as provider>
                        <a href="${provider.loginUrl}" class="kc-social-button">
                            <#if provider.iconClasses?has_content>
                                <i class="${provider.iconClasses}" aria-hidden="true"></i>
                            </#if>
                            <span class="provider-name">${provider.displayName}</span>
                        </a>
                    </#list>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
