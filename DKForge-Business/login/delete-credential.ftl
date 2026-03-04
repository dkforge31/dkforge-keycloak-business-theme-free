<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("deleteCredentialTitle", credentialLabel)}
    <#elseif section = "form">
    <div id="kc-delete-text">
        ${msg("deleteCredentialMessage", credentialLabel)}
    </div>
    <form class="kc-form-business" action="${url.loginAction}" method="POST">
        <input class="kc-button-business" name="accept" id="kc-accept" type="submit" value="${msg("doConfirmDelete")}"/>
        <input class="kc-button-business" name="cancel-aia" value="${msg("doCancel")}" id="kc-decline" type="submit" />
    </form>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
