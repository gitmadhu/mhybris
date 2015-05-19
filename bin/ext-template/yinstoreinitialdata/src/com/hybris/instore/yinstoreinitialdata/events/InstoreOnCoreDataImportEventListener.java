/**
 * 
 */
package com.hybris.instore.yinstoreinitialdata.events;

import de.hybris.platform.commerceservices.setup.events.CoreDataImportedEvent;


public class InstoreOnCoreDataImportEventListener extends AbstractInstoreDataImportEventListener<CoreDataImportedEvent>
{

	@Override
	protected void onEvent(final CoreDataImportedEvent event)
	{
		importImpexFile("/instoresampledata/import/common/instoreemployee-groups.impex", true);
	}
}
