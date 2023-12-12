*** Settings ***
Documentation       Global configuration variables

Library             String
Library             Collections
Library             OperatingSystem
Library             SeleniumLibrary


*** Variables ***
# Server and domain info
${BASE_URL}             https://uat.wsvhrm.com/
${SERVER}               localhost:7272
${LOGIN URL}            http://${SERVER}/
${WELCOME URL}          http://${SERVER}/welcome.html
${ERROR URL}            http://${SERVER}/error.html

# User info
${ADMIN USER}           robot00058@wsvietnam.com
${ADMIN PASSWORD}       Robot@123456
${NORMAL USER}          robot00058@wsvietnam.com
${NORMAL PASSWORD}      Robot@123456

# System
${BROWSER}              Chrome
${DELAY}                0
