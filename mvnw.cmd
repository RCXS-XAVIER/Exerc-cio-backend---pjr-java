@Rem ----------------------------------------------------------------------------
@REM Licenciado para a Apache Software Foundation (ASF) sob um
@REMou mais contratos de licença de contribuinte. Consulte o arquivo NOTICE
@REMdistribuído com este trabalho para obter informações adicionais
@REM emrelação à propriedade de direitos autorais. O ASF licencia este arquivo
@REMpara você sob a Licença Apache, Versão 2.0 (o
@REM"Licença"); você não pode usar este arquivo, exceto em conformidade
@REMcom a Licença. Você pode obter uma cópia da Licença em
@Rem
@https://www.apache.org/licenses/LICENSE-2.0 REM
@Rem
@REM A menos que exigido pela lei aplicável ou acordado por escrito,
@O software REMdistribuído sob a Licença é distribuído em um
@REM "COMO ESTÁ", SEM GARANTIAS OU CONDIÇÕES DE QUALQUER
@REM GENTIL, expresso ou implícito. Consulte a Licença para o
@Idioma específico do REMque rege permissões e limitações
@REMsob a Licença.
@Rem ----------------------------------------------------------------------------

@Rem ----------------------------------------------------------------------------
@REM Script de lote de inicialização do Maven
@Rem
@REM Vars ENV necessárias:
@REM JAVA_HOME - localização de um dir de casa JDK
@Rem
@REM Vars ENV opcionais
@REM M2_HOME - localização do dir doméstico instalado do maven2
@REM MAVEN_BATCH_ECHO - definido como 'on' para permitir a eco dos comandos em lote
@REM MAVEN_BATCH_PAUSE - definido como 'ligado' para aguardar um pressionamento de tecla antes de terminar
@REM MAVEN_OPTS - parâmetros passados para a Java VM ao executar o Maven
@REM, por exemplo, para depurar o próprio Maven, use
@Conjunto REMMAVEN_OPTS=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000
@REM MAVEN_SKIP_RC - sinalizador para desativar o carregamento de arquivos mavenrc
@Rem ----------------------------------------------------------------------------

@REM Comece todas as linhas REM com '@' caso MAVEN_BATCH_ECHO esteja 'ligado'
@ecodesligado
@Título do conjunto REMda janela de comando
título%0
@Habilitar o eco REMdefinindo MAVEN_BATCH_ECHO como 'ativado'
@if "%MAVEN_BATCH_ECHO%" == "on"  echo %MAVEN_BATCH_ECHO%

@REMdefinido %HOME% para equivalente a $HOME
if"%HOME%"==""(set"HOME=%HOMEDRIVE%%HOMEPATH%")

@REM Executar um script definido pelo usuário antes deste
senão"%MAVEN_SKIP_RC%"==""gotoskipRcPre
@Verificação REMpara pré-script, uma vez com o legado .bat terminando e uma vez com o final .cmd
seexistir"%USERPROFILE%\mavenrc_pre.bat"call"%USERPROFILE%\mavenrc_pre.bat" %*
seexistir"%USERPROFILE%\mavenrc_pre.cmd"call"%USERPROFILE%\mavenrc_pre.cmd" %*
:skipRcPre

@setlocal

definirERROR_CODE=0

@REM Para isolar variáveis internas de possíveis scripts de postagem, usamos outro setlocal
@setlocal

@REM==== VALIDAÇÃO DE INÍCIO ====
senão"%JAVA_HOME%"==""gotoOkJHome

eco.
echo Error: JAVA_HOME not found in your environment. >&2
echo Please set the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo.
goto error

:OkJHome
if exist "%JAVA_HOME%\bin\java.exe" goto init

echo.
echo Error: JAVA_HOME is set to an invalid directory. >&2
echo JAVA_HOME = "%JAVA_HOME%" >&2
echo Please set the JAVA_HOME variable in your environment to match the >&2
echo location of your Java installation. >&2
echo.
goto error

@REM ==== END VALIDATION ====

:init

@REM Find the project base dir, i.e. the directory that contains the folder ".mvn".
@REM Fallback to current working directory if not found.

set MAVEN_PROJECTBASEDIR=%MAVEN_BASEDIR%
IF NOT "%MAVEN_PROJECTBASEDIR%"=="" goto endDetectBaseDir

set EXEC_DIR=%CD%
set WDIR=%EXEC_DIR%
:findBaseDir
IF EXIST "%WDIR%"\.mvn goto baseDirFound
cd ..
IF "%WDIR%"=="%CD%" goto baseDirNotFound
set WDIR=%CD%
goto findBaseDir

:baseDirFound
set MAVEN_PROJECTBASEDIR=%WDIR%
cd "%EXEC_DIR%"
goto endDetectBaseDir

:baseDirNotFound
set MAVEN_PROJECTBASEDIR=%EXEC_DIR%
cd "%EXEC_DIR%"

:endDetectBaseDir

SENÃOEXISTIR"%MAVEN_PROJECTBASEDIR%\.mvn\jvm.config"gotoendReadAdditionalConfig

@setlocal EnableExtensions EnableDelayedExpansion
for/F"usebackq delims="%%ain("%MAVEN_PROJECTBASEDIR%\.mvn\jvm.config")dosetJVM_CONFIG_MAVEN_PROPS=! JVM_CONFIG_MAVEN_PROPS! %%a
@endlocal&set JVM_CONFIG_MAVEN_PROPS=%JVM_CONFIG_MAVEN_PROPS%

:endReadAdditionalConfig

SETMAVEN_JAVA_EXE="%JAVA_HOME%\bin\java.exe"
setWRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"
definirWRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

setDOWNLOAD_URL="https://repo.maven.apache.org/maven2/org/apache/maven/wrapper/maven-wrapper/3.1.0/maven-wrapper-3.1.0.jar"

FOR/F"usebackq tokens=1,2 delims=="%%AIN("%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties")DO (
    IF"%%A"=="wrapperUrl"SETDOWNLOAD_URL=%%B
)

@REM Extensão para permitir o download automático do maven-wrapper.jar do Maven-central
@REM Isso permite usar o wrapper maven em projetos que proíbem a verificação de dados binários.
seexistir%WRAPPER_JAR% (
    if"%MVNW_VERBOSE%"=="verdadeiro" (
        eco Encontrado%WRAPPER_JAR%
    )
) mais (
    senão"%MVNW_REPOURL%" == "" (
        SETDOWNLOAD_URL="%MVNW_REPOURL%/org/apache/maven/wrapper/maven-wrapper/3.1.0/maven-wrapper-3.1.0.jar"
    )
    if"%MVNW_VERBOSE%"=="verdadeiro" (
        eco Não foi possível encontrar%WRAPPER_JAR%, baixá-lo ...
        eco Baixando de:%DOWNLOAD_URL%
    )

    powershell-Comando"&{"^
		"$webclient = new-object System.Net.WebClient; "^
		"if (-not ([string]::IsNullOrEmpty('%MVNW_USERNAME%') -and [string]::IsNullOrEmpty('%MVNW_PASSWORD%'))) {"^
		"$webclient. Credentials = new-object System.Net.NetworkCredential('%MVNW_USERNAME%', '%MVNW_PASSWORD%'); "^
		"}"^
		"[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $webclient. DownloadFile('%DOWNLOAD_URL%', '%WRAPPER_JAR%')"^
		"}"
    if"%MVNW_VERBOSE%"=="verdadeiro" (
        eco Download concluído%WRAPPER_JAR%
    )
)
@REM Fim da prorrogação

@REM Fornecer uma maneira "padronizada" de recuperar os args da CLI que irão
@O REMfunciona com execuções do Windows e de outros Windows.
definirMAVEN_CMD_LINE_ARGS=%*

%MAVEN_JAVA_EXE% ^
  %JVM_CONFIG_MAVEN_PROPS% ^
  %MAVEN_OPTS% ^
  %MAVEN_DEBUG_OPTS% ^
  -classpath %WRAPPER_JAR% ^
  "-Dmaven.multiModuleProjectDirectory=%MAVEN_PROJECTBASEDIR%" ^
  %WRAPPER_LAUNCHER% %MAVEN_CONFIG% %*
seERRORLEVEL1gotoerro
gotofim

:erro
definirERROR_CODE=1

:fim
@endlocal&set ERROR_CODE=%ERROR_CODE%

senão"%MAVEN_SKIP_RC%"==""gotoskipRcPost
@Verificação REMpara script postal, uma vez com o legado .bat terminando e uma vez com o final .cmd
seexistir"%USERPROFILE%\mavenrc_post.bat"call"%USERPROFILE%\mavenrc_post.bat"
seexistir"%USERPROFILE%\mavenrc_post.cmd"call"%USERPROFILE%\mavenrc_post.cmd"
:skipRcPost

@REMpause o script se MAVEN_BATCH_PAUSE estiver definido como 'ativado'
if "%MAVEN_BATCH_PAUSE%"=="on" pause

if "%MAVEN_TERMINATE_CMD%"=="on" exit %ERROR_CODE%

cmd/Csaída/B%ERROR_CODE%