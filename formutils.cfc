<!--- 
LICENSE 
Copyright 2007 Brian Kotek
Updated 2018 James Mohler
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at
       http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--->

<cfcomponent name="FormUtilities" hint="Form Utilities">
	

<cfscript>
any function init(boolean updateFormScope = true, boolean trimFields = true) output="false" {

	variables.instance.updateFormScope = arguments.updateFormScope;
	variables.instance.trimFields = arguments.trimFields;
	return this;
}


struct function compareLists(required any originalList, required any newList) output="false" 
	hint="Given two versions of a list, I return a struct containing the values that were added, the values that were removed, and the values that stayed the same." {

	local.results = {
		addedList 	: [],
		removedList 	: [],
		sameList 		: []
		};
		
	for (local.thisItem in arguments.originalList.ListToArray())	{

		if (arguments.newList.ListFindNoCase(local.thisItem)) {
			local.results.sameList.append(local.thisItem);
		}
		else {
			local.results.removedList.append(local.thisItem);
		}
	}

	for (local.thisItem in arguments.newList.ListToArray()) {
		if (!ListFindNoCase(arguments.originalList, local.thisItem)) {
			local.results.addedList.append(local.thisItem);
		}
	}

	return local.results;
}


any function buildFormCollections(required struct formScope, boolean updateFormScope = variables.instance.updateFormScope, boolean trimFields = variables.instance.trimFields) output="false" {

	local.tempStruct = {'formCollectionsList' : ""};


	for (local.thisField in arguments.formScope) {

		local.thisField = Trim(local.thisField);

		// If the field has a dot or a bracket...
		if (hasFormCollectionSyntax(local.thisField)) {

			// Add collection to list if not present.
			local.tempStruct['formCollectionsList'] = addCollectionNameToCollectionList(local.tempStruct['formCollectionsList'], local.thisField);

			local.currentElement = local.tempStruct;

			// Loop over the field using . as the delimiter.
			local.delimiterCounter = 1;

			for (local.thisElement in local.thisField.ListToArray(".")) { 
				local.tempElement = local.thisElement;
				local.tempIndex = 0;

				// If the current piece of the field has a bracket, determine the index and the element name.
				if (local.tempElement contains "[") {
					local.tempIndex = ReReplaceNoCase(local.tempElement, '.+\[|\]', '', 'all');
					local.tempElement = ReReplaceNoCase(local.tempElement, '\[.+\]', '', 'all');
					}

				// If there is a temp element defined, means this field is an array or struct.
				if (!local.currentElement.keyExists(local.tempElement)) {

					// If tempIndex is 0, it's a Struct, otherwise an Array.
					local.currentElement[local.tempElement] = (local.tempIndex == 0) ? {} : [];
					}

				// If this is the last element defined by dots in the form field name, assign the form field value to the variable.
				if (local.delimiterCounter == local.thisField.ListLen('.')) {

					if (local.tempIndex == 0) {
						local.currentElement[local.tempElement] = arguments.formScope[local.thisField];
					}
					else {
						local.currentElement[local.tempElement][local.tempIndex] = arguments.formScope[local.thisField];
					}
				}

				// Otherwise, keep going through the field name looking for more structs or arrays.
				else	{

					// If this field was a Struct, make the next element the current element for the next loop iteration.
					if (local.tempIndex == 0) {
						local.currentElement = local.currentElement[local.tempElement];
					}
					else	{
						if (local.currentElement[local.tempElement].isEmpty()
							|| local.currentElement[local.tempElement].Len() < local.tempIndex
							|| !local.currentElement[local.tempElement].isDefined(local.tempIndex)) {
							local.currentElement[local.tempElement][local.tempIndex] = {};
							}
	
						// Make the next element the current element for the next loop iteration.
						local.currentElement = local.currentElement[local.tempElement][local.tempIndex];
						}

					local.delimiterCounter++;
				}
			}	// end for
		}
	} // end formscope	
		
	// Done looping. If we've been set to update the form scope, append the created form collections to the form scope.
	if (arguments.updateFormScope) {
		arguments.formScope.append(local.tempStruct);
	}

	return local.tempStruct;
}


private boolean function hadFormCollectionSyntax(required any fieldName) output="false" 
	hint="I determine if the field has the form collection syntax, meaning it contains a dot or a bracket." {

	return arguments.fieldName contains "." || arguments.fieldName contains "[";
}

private string function addCollectionNameToCollectionList(required string formCollectionsList, required string fieldName)  output="false" 
	hint="I add the collection name to the list of collection names if it isn't already there." {


	if (!ListFindNoCase(arguments.formCollectionsList, ReReplaceNoCase(arguments.fieldName, '(\.|\[).+', ''))) {
		arguments.formCollectionsList = ListAppend(arguments.formCollectionsList, ReReplaceNoCase(arguments.fieldName, '(\.|\[).+', ''));
	}
	return arguments.formCollectionsList;
}
</cfscript>	
</cfcomponent>