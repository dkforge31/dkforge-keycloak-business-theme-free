<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "user-profile-commons.ftl" as userProfileCommons>
<@layout.registrationLayout displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>

    <#if section = "header">
        ${msg("registerTitle")}

    <#elseif section = "form">

        <div class="kc-register-form-business">

            <form id="kc-register-form" class="kc-form" action="${url.registrationAction}" method="post">

                <!-- USERNAME -->
            <#if !realm.registrationEmailAsUsername>
                <@field.input name="username" 
                             label=msg("username")
                             value="${(register.formData.username!'')}"
                             required=true/>
            </#if>
                <!-- EMAIL -->
                <@field.input name="email" 
                             label=msg("email")
                             value="${(register.formData.email!'')}"
                             required=true
                             autocomplete="email"/>

                <!-- FIRST NAME -->
                <@field.input name="firstName" 
                             label=msg("firstName")
                             value="${(register.formData.firstName!'')}"
                             required=true/>

                <!-- LAST NAME -->
                <@field.input name="lastName" 
                             label=msg("lastName")
                             value="${(register.formData.lastName!'')}"
                             required=true/>

                <!-- PASSWORD -->
                <#if passwordRequired??>
                    <@field.password name="password" 
                                    label=msg("password")
                                    required=true
                                    autocomplete="new-password"/>

                    <@field.password name="password-confirm" 
                                    label=msg("passwordConfirm")
                                    required=true
                                    autocomplete="new-password"/>
                </#if>

                <#-- Dynamic Profile Attributes -->
                <#assign reservedAttributes = ['username', 'email', 'firstName', 'lastName', 'password', 'password-confirm', 'locale', 'languages']>
                <#if profile?? && profile.attributes??>
                    <#list profile.attributes as attribute>
                        <#if !reservedAttributes?seq_contains(attribute.name)>
                            <#assign attrError="">
                            <#if messagesPerField.existsError(attribute.name)>
                                <#assign attrError=messagesPerField.getFirstError(attribute.name)>
                            </#if>
                            
                            <div class="kc-form-group">
                                <label for="${attribute.name}" class="form-label">
                                    ${advancedMsg(attribute.displayName!'')!attribute.name}
                                    <#if attribute.required><span aria-hidden="true">*</span></#if>
                                </label>
                                <@userProfileCommons.inputFieldByType attribute=attribute/>
                                <#if attrError?has_content>
                                    <span class="kc-error-msg" aria-live="polite">
                                        ${kcSanitize(attrError)?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </#if>
                    </#list>
                </#if>

                <button type="submit" class="kc-button-business">${msg("doRegister")}</button>

                <div class="kc-login-prompt kc-registration-info">
                    <span>${msg("noAccount")}</span>
                    <a href="${url.loginUrl}" class="kc-signup-link">${msg("doLogIn")}</a>
                </div>

            </form>
        </div>

    </#if>

</@layout.registrationLayout>
