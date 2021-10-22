package com.softwareag.gcs.wm.codereview.operations;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.softwareag.gcs.wm.codereview.utils.FlowUtilities;
import com.softwareag.gcs.wm.codereview.utils.LogWriter;

public class SampleOperation extends Operation
{

    /**
     * Performs the code review check item
     */
    @Override
    public void performCheckOperation()
    {
	// Validate the parameters
	if(!isParametersValid()) throw new RuntimeException("Parameters are invalid");

	// check if a flow service implementation exists
	List<String> flowServiceNodes = this.getFlowServiceNodeNDFList();
	List<String> flowServiceImpl = this.getFlowXmlFileList();

	// Loop through the flow serivce nodes, get the name of the service,
	// check this exists in the xml implementation

	for(Iterator<String> iterator = flowServiceNodes.iterator(); iterator.hasNext();)
	{
	    String flowNodeFile = (String) iterator.next();

	    String fullServiceName = FlowUtilities.getServiceName(flowNodeFile);
	    String serviceName = fullServiceName.split("\\:")[1];

	    boolean assertion = false;
	    for(Iterator<String> xmlIterator = flowServiceImpl.iterator(); xmlIterator.hasNext();)
	    {
		String flowXmlPath = (String) xmlIterator.next();
		String fullXmlServiceName = FlowUtilities.getServiceName(flowXmlPath);
		String xmlServiceName = fullXmlServiceName.split("\\:")[1];

		if(xmlServiceName.equals(serviceName))
		{
		    assertion = true;
		    break;
		}

	    }
	    this.addTestResults(assertion, fullServiceName, Boolean.toString(assertion));

	}
    }


    /**
     * Check the parameters are valid
     * 
     * @return
     */
    private boolean isParametersValid()
    {
	List<String> parameters = this.getParameters();
	// todo do some checking of the parameters you put into the config xml
	if(parameters != null)
	    return true;
	else return false;
    }

    public static void main(String[] args)
    {
	SampleOperation self = new SampleOperation();
	LogWriter.setLogLevel("TRACE");
	List<String> parameters = new ArrayList<String>();

	self.initialize("1", "IotDemo", "C:\\Jenkins\\jobs\\IotDemo\\workspace\\IotDemo", parameters, null, null, null, false, null);
	self.performOperation();
    }
}
