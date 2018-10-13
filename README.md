# Brian Kotek's Form Utilites



## Description

The main capability of this CFC is to generate arrays and structures on the ColdFusion server based on the names of your form fields. So a form field named `user.firstName` would create a structure named `user` with a key of `firstName`, holding the value of that field.

It will also generate arrays. A form field named `user[1].firstName` would create an array, with the first element in the array being a structure called `user` with a key of `firstName`.

These can be created to any arbitrary level of complexity.

The CFC also has a handy function that will take an original list and a new list, and return a structure telling you what was added to the the list, removed from the list, and what stayed in the list. Useful for handling forms with checkboxes.

Fix added to handle situations where a form collection key and a form field had the same name.

## Updated

* This utility has been updated for ColdFusion 2016 and above.
* Rewritten using cfscript
* Includes table example
* Includes Commandbox config
* Forms look better with Bulma 


## Getting Started with CommandBox

No need to download Adobe ColdFusion or Lucee. Commandbox does it all automatically

Get Ortus Solutions [Commandbox](https://www.ortussolutions.com/products/commandbox) The downloads are at the bottom of the page

Download this repository to favorite directory.

* On MacOS, my favorite is `~/Sites/ColdFusion/FormUtils`
* On Windows, my favorite is `C:\Users\[username]\Documents\Sites\ColdFusion\FormUtils`

In a terminal window, navigate to the appropriate directory

Type `box` <enter>

Type `start` <enter>

index.cfm automatically starts.

It is really that easy. This is why I recommend CommandBox


## Getting Started without CommandBox

Download this repository to subdirectory off off in the webroot.

Navigate to subdirectory

index.cfm may or may not show up depending on your webserver settings.


## Original Version

http://formutils.riaforge.org/

