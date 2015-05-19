/**
 *
 */
package com.hybris.instore.yinstoreinitialdata.events;


import de.hybris.platform.commerceservices.setup.data.ImportData;
import de.hybris.platform.commerceservices.setup.events.SampleDataImportedEvent;

import org.apache.log4j.Logger;


public class InstoreOnSampleDataImportEventListener extends AbstractInstoreDataImportEventListener<SampleDataImportedEvent>
{

	private static final Logger LOG = Logger.getLogger(InstoreOnSampleDataImportEventListener.class);

	@Override
	protected void onEvent(final SampleDataImportedEvent event)
	{
		for (final ImportData importData : event.getImportData())
		{
			for (final String storeName : importData.getStoreNames())
			{
				LOG.info("Importing In-Store sample data for store [" + storeName + "]");
				importInStoreContextForBaseStore(storeName);
			}
		}
	}

	private void importInStoreContextForBaseStore(final String storeUid)
	{
		importImpexFile("/instoresampledata/import/stores/" + storeUid + "/instore.impex", false);
		importImpexFile("/instoresampledata/import/stores/" + storeUid + "/solr.impex", false);
		importImpexFile("/instoresampledata/import/stores/" + storeUid + "/instore-employees.impex", false);
	}
}
