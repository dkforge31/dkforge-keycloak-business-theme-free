<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=true; section>
    <#if section = "header">
        ${msg("emailVerifyTitle")}
    <#elseif section = "form">
        <div class="kc-content-wrapper-business">
            <p class="kc-instruction-business">
                <#if verifyEmail??>
                    ${msg("emailVerifyInstruction1",verifyEmail)}
                <#else>
                    ${msg("emailVerifyInstruction4",user.email)}
                </#if>
            </p>
        </div>
        <#if isAppInitiatedAction??>
            <form id="kc-verify-email-form" class="kc-form-business" action="${url.loginAction}" method="post">
                <div class="kc-form-group-business">
                    <div id="kc-form-buttons" class="kc-form-buttons-business">
                        <#if verifyEmail??>
                            <input class="kc-button-business kc-button-default-business kc-button-large-business" type="submit" value="${msg("emailVerifyResend")}" />
                        <#else>
                            <input class="kc-button-business kc-button-primary-business kc-button-large-business" type="submit" value="${msg("emailVerifySend")}" />
                        </#if>
                        <button class="kc-button-business kc-button-default-business kc-button-large-business" type="submit" name="cancel-aia" value="true" formnovalidate>${msg("doCancel")}</button>
                    </div>
                </div>
            </form>
        </#if>
    <#elseif section = "info">
        <#if !isAppInitiatedAction??>
            <div class="kc-content-wrapper-business">
                <p class="kc-instruction-business kc-registration-info">
                    ${msg("emailVerifyInstruction2")}
                    <br/>
                    <a href="${url.loginAction}" class="kc-link-business">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
                </p>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
