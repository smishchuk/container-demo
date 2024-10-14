﻿<cfcomponent
    displayname="Application"
    output="true"
    hint="Handle the application.">
	

    <!--- Set up the application. --->
    <cfset this.Name = "container-demo" />
	<cfset this.applicationTimeout = createTimeSpan( 0, 0, 3, 0 ) />
  	<cfset this.sessionmanagement="Yes"/>
  	<cfset this.clientmanagement="No"/>
  	<cfset this.sessiontimeout=CreateTimeSpan(0, 0, 120, 0)/>
  	<cfset this.setclientcookies="No"/>
  
	<cfset this.datasource = "testds"/><!--- default datasource name --->
	<cfset getDS(this.datasource,this.datasource)/><!--- datasource name, environment variable prefix without "_" --->
		
    <!--- Define the page request properties. --->
    <cfsetting
        requesttimeout="20"
        showdebugoutput="false"
        enablecfoutputonly="false"
     />

    <cffunction
        name="OnApplicationStart"
        access="public"
        returntype="boolean"
        output="false"
        hint="Fires when the application is first created.">

        <cfreturn true />
    </cffunction>


    <cffunction
        name="OnRequest"
        access="public"
        returntype="void"
        output="true"
        hint="Fires after pre page processing is complete.">
		
        <cfargument name="template" type="string" required="true"/>
		
		<cfset request.startTickCount=getTickCount()/>
        
		<cfset setEncoding("FORM", "UTF-8")>
		<cfset setEncoding("URL", "UTF-8")>
	
		<!--- global settings --->
		<cfset request.APP_VERSION="0.00.000"/><!---2024-10-13 15:26:10--->		
		<cflock scope="application" type="readonly" timeout=3>
			<cfset request.DS=this.datasource/>
			<cfset request.APP_NAME=this.Name/>
		</cflock>		

		<cfset local = {} />

        <cfset local.basePath = getDirectoryFromPath(
            getCurrentTemplatePath()
            ) />

        <cfset local.targetPath = getDirectoryFromPath(
            expandPath( arguments.template )
            ) />

        <cfset local.requestDepth = (
            listLen( local.targetPath, "\/" ) -
            listLen( local.basePath, "\/" )
            ) />

        <cfset request.webRoot = repeatString(
            "../",
            local.requestDepth
            ) />

        <!---
            While we wouldn't normally do this for every page
            request (it would normally be cached in the
            application initialization), I'm going to calculate
            the site URL based on the web root.
        --->
        <cfset request.siteUrl = (
			IIF(
				(CGI.server_port_secure <!--- CGI.https EQ "On" does not work with apache+tomcat and nginx+tomcat --->),
				DE( "https://" ),
				DE( "http://" )
				) &
            cgi.http_host &
            reReplace(
                getDirectoryFromPath( arguments.template ),                "([^\\/]+[\\/]){#local.requestDepth#}$",
                "",
                "one"
                )
            ) />

		<cfset request.thisPage=Replace(ReplaceNoCase(expandPath(ARGUMENTS.template), local.basePath, ""), "\", "/")/>		
		
		<cfcookie name="CFID" value="#session.CFID#">
		<cfcookie name="CFTOKEN" value="#session.CFTOKEN#">
		
		<cfinclude template="#ARGUMENTS.template#"/>

        <cfreturn />
    </cffunction>
	
	<cffunction
        name="getDS"
        access="private"
        returntype="void"
        output="false"
        hint="Configure data source from environment variables. Convention: data source name is an environment varialble prefix">
		
		<cfargument name="dsname" type="string" required="true"/>
		<cfargument name="prefix" type="string" default=#dsname#/>
		
		<cfset system = createObject("java", "java.lang.System")/>
		<cfset var ds={}/>
		
		<cfloop list="class,connectionString,database,driver,host,port,type,url,username,password,bundleName,bundleVersion,connectionLimit,liveTimeout,validate" item="field">
			<cfset var value=system.getEnv("#arguments.prefix#_#field#")/>
			<cfif isDefined("value") AND len(value)>
				<cfset structInsert(ds,field,value)/>
			</cfif>			
		</cfloop>		
		
		<cfset THIS.datasources[dsname] = ds> 
        <cfreturn />
		<!--- this.datasources["cmdb"] = {
			class: "org.postgresql.Driver", 
			bundleName: "org.postgresql.jdbc", 
			bundleVersion: "42.6.0",
			connectionString: "jdbc:postgresql://localhost:5432/cmdb-prod",
			username: "appserver",
			password: "encrypted:32d8bd3b0609b261d018082e5481a7299318f66993949bf0489d1d529559240d26c8df6c9c55495e93bec433bbfb3cb8796304839812cea0",
			
			// optional settings
			connectionLimit:5, // default:-1
			liveTimeout:15, // default: -1; unit: minutes
			validate:false, // default: false
		}; --->
    </cffunction>


    <cffunction
        name="OnRequestEnd"
        access="public"
        returntype="void"
        output="true"
        hint="Fires after the page processing is complete.">
		<!--- Attention! Before CF9, OnrequestEnd is not executed in case of redirect. That is why we use session.save_login --->

        <cfreturn />
    </cffunction>


</cfcomponent>