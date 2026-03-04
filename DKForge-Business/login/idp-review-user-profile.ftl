<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayRequiredFields=true; section>
    <#if section = "header">
        ${msg("loginIdpReviewProfileTitle")}
    <#elseif section = "form">
        <form id="kc-idp-review-profile-form" class="kc-form-business" action="${url.loginAction}" method="post">

            <@userProfileCommons.userProfileFormFields/>

            <div class="kc-form-group-business">
                <div id="kc-form-options" class="kc-form-options-business">
                    <div class="kc-form-options-wrapper-business">
                    </div>
                </div>

                <div id="kc-form-buttons" class="kc-form-buttons-business">
                    <input class="kc-button-business" type="submit" value="${msg("doSubmit")}" />
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>