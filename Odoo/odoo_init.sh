#!/bin/bash
#
# Developed Qualsys Consulting
# Contact luis_homobono@qualsys.com.mx
#
#==================================== Colors ===============================================
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtrst='\e[0m' # Reset color
#==================================== Functions ===============================================
sd(){
    clear;
    echo -e "
        ${txtgrn}======================
            Instalar sudo!
        ${txtrst}";
    apt-get update;
    apt install -y sudo;
    echo -e "
        ${txtgrn}======================
            Ejecutado!
        ${txtrst}";
}

utils(){
    echo -e "
        ${txtgrn}======================
            Instalar programas básicos!
            - nano
            - wget
            - net-tools
            - software-properties-common
        ${txtrst}";
    sudo apt install nano;
    sudo apt install wget;
    sudo apt install net-tools;
    sudo apt install software-properties-common;
    sudo apt install dpkg;
    echo -e "
        ${txtgrn}======================
            Ejecutado!
        ${txtrst}";
}

yanthescript(){
    echo -e "
        ${txtgrn}======================
            Descarga de Script Yanthe666
            https://github.com/Yenthe666/InstallScript
        ${txtrst}"
    wget https://raw.githubusercontent.com/Yenthe666/InstallScript/$1/odoo_install.sh;
    echo -e "
            ${txtgrn}Configuraciones de Script Yanthe666
            https://github.com/Yenthe666/InstallScript
        ${txtrst}"
    if [ $2 = "True" ]; then
        echo -e "${txtgrn}Configuración de Versión Enterprise${txtrst}"
        sed 's/IS_ENTERPRISE="False"/IS_ENTERPRISE="True"/g' -i  odoo_install.sh
    else
        echo -e "${txtred}Don't set Enterprise Version${txtrst}"
    fi;
    chmod +x odoo_install.sh;
    ./odoo_install.sh
    echo -e "
        ${txtgrn}======================
            Ejecutado Script Yanthe666
            https://github.com/Yenthe666/InstallScript
        ${txtrst}"
}

postgresconf(){
    echo -e "
        ${txtgrn}======================
            Configuración de usuario odoo (PostgreSQL)!
        ${txtrst}";
    sudo service postgresql start
    su - postgres -c 'psql -c "CREATE ROLE odoo LOGIN SUPERUSER INHERIT CREATEDB CREATEROLE;"'
    sudo service odoo-server stop
    sudo service postgresql stop
    echo -e "
        ${txtgrn}======================
            Usuario Creado!
        ${txtrst}"
}

welcome(){
    VERSION_SYS=$(cat /etc/issue | cut -d ' ' -f 2 | cut -d '.' -f 1,2)
    echo -e "
        ${txtgrn}===================================
            Bienvenido a Odoo init!
            ${txtgrn}Desarrollado por Qualsys Consulting

            Script dedicado a instalar Odoo en contendedor de Ubuntu

            Detectamos que tienes $VERSION_SYS
            ${txtred}Nota: Si estas instalando la versión 12.0 o anteriores te recomendamos Ubuntu 18.04${txtrst}
        ${txtgrn}===================================
        ${txtrst}"
    # echo 'Introduzca un la versión de Odoo que desee (Ejem: 14.0, 13.0, 12.0, etc):'
    echo -e "${txtgrn}Introduce la versión de Odoo que desees instalar (Ejem: 14.0, 13.0, 12.0, etc):${txtrst}"
    read VERSION_ODOO
    echo -e "${txtred}¿Deseas instalar la versión Enterprise? (Y/n):${txtrst}"
    read ENTERPRISE
    if [[ $ENTERPRISE = "n" || $ENTERPRISE = "N" ]]; then
        ENTERPRISE="False"
    else
        ENTERPRISE="True"
    fi
    echo -e "
        ${txtgrn}======================
            Ubuntu: $VERSION_SYS
            Odoo Versión: $VERSION_ODOO
            Enterprise Edition: $ENTERPRISE
        ======================
        ${txtrst}"
    echo -e "
            ${txtred}Confirmar para empezar (Y/n)
        ${txtrst}"
    read CONFIRM;
    if [[ $CONFIRM = "n" || $CONFIRM = "N" ]]; then
        echo -e "
            ${txtgrn}======================
                Bye!
            ${txtrst}"
    else
        sd;
        echo -e "
                ${txtred}Enter para continuar:
            ${txtrst}"
        read var1;
        utils;
        echo -e "
                ${txtred}Enter para continuar:
            ${txtrst}"
        read var1;
        yanthescript $VERSION_ODOO $ENTERPRISE;
        echo -e "
                ${txtred}Enter para continuar:
            ${txtrst}"
        read var1;
        postgresconf;
        echo -e "
            ${txtgrn}======================
                Instalación Finalizada
                Bye!
            ${txtrst}"
    fi
}
welcome;
