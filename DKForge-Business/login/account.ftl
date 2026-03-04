<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        ${msg("loginProfileTitle")}
    <#elseif section = "form">
        <div class="kc-form-content">
            <h2 class="form-title">${msg("businessIconAccount")} ${msg("loginProfileTitle")}</h2>
            
            <form class="kc-business-form" action="${url.accountUrl}" method="post">
                <div class="kc-form-group">
                    <label for="username" class="form-label">${msg("username")}</label>
                    <input type="text" id="username" value="${(account.username!'')}" class="kc-input-business" disabled />
                </div>

                <div class="kc-form-group">
                    <label for="email" class="form-label">${msg("email")}</label>
                    <input type="text" id="email" name="email" value="${(account.email!'')}" class="kc-input-business" aria-invalid="<#if messagesPerField.existsError('email')>true<#else>false</#if>" />
                    <#if messagesPerField.existsError('email')>
                        <span class="error-message">${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}</span>
                    </#if>
                </div>

                <div class="kc-form-group">
                    <label for="firstName" class="form-label">${msg("firstName")}</label>
                    <input type="text" id="firstName" name="firstName" value="${(account.firstName!'')}" class="kc-input-business" />
                </div>

                <div class="kc-form-group">
                    <label for="lastName" class="form-label">${msg("lastName")}</label>
                    <input type="text" id="lastName" name="lastName" value="${(account.lastName!'')}" class="kc-input-business" />
                </div>

                <button type="submit" class="kc-button-business">${msg("doSubmit")}</button>

                <div style="text-align: center; margin-top: 16px;">
                    <a href="${url.updatePasswordUrl}" style="color: #1976d2; text-decoration: none; font-weight: 600;">${msg("changePasswordLink")} →</a>
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>
