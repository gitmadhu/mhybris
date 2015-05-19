/*
 * [y] hybris Platform
 *
 * Copyright (c) 2000-2013 hybris AG
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of hybris
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with hybris.
 * 
 *  
 */
package com.hybris.instore.yinstoreinitialdata.setup;

import de.hybris.platform.commerceservices.setup.AbstractSystemSetup;
import de.hybris.platform.core.initialization.SystemSetup;
import de.hybris.platform.core.initialization.SystemSetup.Process;
import de.hybris.platform.core.initialization.SystemSetup.Type;
import de.hybris.platform.core.initialization.SystemSetupContext;
import de.hybris.platform.core.initialization.SystemSetupParameter;
import de.hybris.platform.core.initialization.SystemSetupParameterMethod;

import java.util.ArrayList;
import java.util.List;

import com.hybris.instore.yinstoreinitialdata.constants.YinstoreinitialdataConstants;


@SystemSetup(extension = YinstoreinitialdataConstants.EXTENSIONNAME)
public class YInStoreInitialDataSetup extends AbstractSystemSetup
{

	private static final String IMPORT_INSTORE_EMPLOYEES = "importInstoreEmployees";

	@Override
	@SystemSetupParameterMethod
	public List<SystemSetupParameter> getInitializationOptions()
	{
		final List<SystemSetupParameter> params = new ArrayList<SystemSetupParameter>();
		params.add(createBooleanSystemSetupParameter(IMPORT_INSTORE_EMPLOYEES, "Import In-Store Employees", true));
		return params;
	}

	@SystemSetup(type = Type.PROJECT, process = Process.ALL)
	public void createProjectData(final SystemSetupContext context)
	{
		importImpexFile(context, "/instoresampledata/import/common/instoreemployee-groups.impex", true);
		importInStoreContextForBaseStore(context, "electronics");
		importInStoreContextForBaseStore(context, "apparel-uk");
		importInStoreContextForBaseStore(context, "apparel-de");
	}

	private void importInStoreContextForBaseStore(final SystemSetupContext context, final String storeUid)
	{
		importImpexFile(context, "/instoresampledata/import/stores/" + storeUid + "/instore.impex", true);
		importImpexFile(context, "/instoresampledata/import/stores/" + storeUid + "/solr.impex", true);
		if (getBooleanSystemSetupParameter(context, IMPORT_INSTORE_EMPLOYEES))
		{
			importImpexFile(context, "/instoresampledata/import/stores/" + storeUid + "/instore-employees.impex", true);
		}
	}

}
