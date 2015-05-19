/**
 * 
 */
package com.hybris.instore.yinstoreinitialdata.events;

import de.hybris.platform.commerceservices.setup.SetupImpexService;
import de.hybris.platform.commerceservices.setup.events.AbstractDataImportEvent;
import de.hybris.platform.servicelayer.event.impl.AbstractEventListener;

import org.springframework.beans.factory.annotation.Required;


public abstract class AbstractInstoreDataImportEventListener<T extends AbstractDataImportEvent> extends AbstractEventListener<T>
{
	private SetupImpexService setupImpexService;

	protected SetupImpexService getSetupImpexService()
	{
		return setupImpexService;
	}

	protected void importImpexFile(final String file, final boolean errorIfMissing)
	{
		getSetupImpexService().importImpexFile(file, errorIfMissing);
	}

	@Required
	public void setSetupImpexService(final SetupImpexService setupImpexService)
	{
		this.setupImpexService = setupImpexService;
	}
}
