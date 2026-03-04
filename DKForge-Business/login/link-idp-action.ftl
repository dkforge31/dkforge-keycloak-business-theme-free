<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        ${msg("linkIdpActionTitle", idpDisplayName)}
    <#elseif section = "form">
    <div id="kc-link-text">
        ${msg("linkIdpActionMessage", idpDisplayName)}
    </div>
    <form class="kc-form-business" action="${url.loginAction}" method="POST">
        <input class="kc-button-business" name="continue" id="kc-continue" type="submit" value="${msg("doContinue")}"/>
        <input class="kc-button-business" name="cancel-aia" value="${msg("doCancel")}" id="kc-cancel" type="submit" />
    </form>
    <div class="clearfix"></div>
    </#if>
</@layout.registrationLayout>
