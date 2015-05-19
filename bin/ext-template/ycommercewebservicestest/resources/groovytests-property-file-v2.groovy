/*
 * [y] hybris Platform
 *
 * Copyright (c) 2000-2014 hybris AG
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of hybris
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with hybris.
 */

HOST='localhost'
PORT=9001
SECURE_PORT=9002
BASE="http://${HOST}:${PORT}/${WEBROOT}/v2/wsTest"
SECURE_BASE="https://${HOST}:${SECURE_PORT}/${WEBROOT}/v2/wsTest"
OAUTH2_TOKEN_ENDPOINT="https://${HOST}:${SECURE_PORT}/${WEBROOT}/oauth/token"
CLIENT_ID='mobile_android'
CLIENT_SECRET='secret'
TRUSTED_CLIENT_ID='trusted_client'
TRUSTED_CLIENT_SECRET='secret'
REDIRECT_URI="http://${HOST}:8080/oauth2_callback"
LOGOUT_URL="https://${HOST}:${SECURE_PORT}/${WEBROOT}/v2/customers/current/logout"

USERNAME='democustomer'
PASSWORD='1234'
FAIL_ON_NAMING_CONVENTION_ERROR=false