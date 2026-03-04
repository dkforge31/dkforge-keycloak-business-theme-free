<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>

    <#if section = "header">
        ${msg("updatePasswordTitle")}

    <#elseif section = "form">

        <div class="kc-form-content">
            <h2 class="form-title">🔐 ${msg("updatePasswordTitle")}</h2>

            <form class="kc-business-form"
                  action="<#if url.updatePasswordUrl??>${url.updatePasswordUrl}<#else>${url.loginAction}</#if>"
                  method="post">

                <#-- Only show current password field if Keycloak provided the object -->
                <#if password?? && password.passwordSet>
                    <div class="kc-form-group">
                        <label for="password">${msg("currentPassword")}</label>
                        <div class="kc-password-wrapper">
                            <input type="password" id="password" name="password" class="kc-input-business" 
                                   aria-invalid="<#if messagesPerField.existsError('password')>true<#else>false</#if>" />
                            <button class="kc-toggle-password" type="button" aria-controls="password" data-password-toggle
                                    data-icon-show="bi-eye" data-icon-hide="bi-eye-slash">🔐<i class="bi bi-eye" style="display:none;"></i></button>
                        </div>
                        <#if messagesPerField.existsError('password')>
                            <span class="kc-error-msg" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </#if>

                <div class="kc-form-group">
                    <label for="password-new">${msg("passwordNew")}</label>
                    <div class="kc-password-wrapper">
                        <input type="password" id="password-new" name="password-new" class="kc-input-business" 
                               aria-invalid="<#if messagesPerField.existsError('password-new')>true<#else>false</#if>" />
                        <button class="kc-toggle-password" type="button" aria-controls="password-new" data-password-toggle
                                data-icon-show="bi-eye" data-icon-hide="bi-eye-slash">🔐<i class="bi bi-eye" style="display:none;"></i></button>
                    </div>
                    <#if messagesPerField.existsError('password-new')>
                        <span class="kc-error-msg" aria-live="polite">
                            ${kcSanitize(messagesPerField.getFirstError('password-new'))?no_esc}
                        </span>
                    </#if>
                </div>

                <div class="kc-form-group">
                    <label for="password-confirm">${msg("passwordVerify")}</label>
                    <div class="kc-password-wrapper">
                        <input type="password" id="password-confirm" name="password-confirm" class="kc-input-business" 
                               aria-invalid="<#if messagesPerField.existsError('password-confirm')>true<#else>false</#if>" />
                        <button class="kc-toggle-password" type="button" aria-controls="password-confirm" data-password-toggle
                                data-icon-show="bi-eye" data-icon-hide="bi-eye-slash">🔐<i class="bi bi-eye" style="display:none;"></i></button>
                    </div>
                    <#if messagesPerField.existsError('password-confirm')>
                        <span class="kc-error-msg" aria-live="polite">
                            ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}
                        </span>
                    </#if>
                </div>

                <button type="submit" class="kc-button-business">${msg("updatePasswordTitle")}</button>
            </form>
        </div>

    </#if>

</@layout.registrationLayout>
