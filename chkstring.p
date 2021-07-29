
/*------------------------------------------------------------------------
    File        : chkstring.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Scott Auge
    Created     : Wed Jul 28 20:17:35 EDT 2021
    Notes       : Check on string parameters
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

function ShowArgs returns character (input Arg as character):
  
  define variable DynArg as DynArgs no-undo.
  define variable R as character no-undo.
  
  DynArg = new DynArgs(Arg).

  R = DynArg:U2S(DynArg:ByName("B")).
  return R.
  
end.

define variable D as DynArgs no-undo.

D = new DynArgs("").

// A space and the , and the " and the ' are meta characters
// Perhaps [meta] or something
 
disp ShowArgs(
         D:SetParameter("A", "This should be stored as underlined", "char") +
         "," +
         D:SetParameter("B", "Another stored as underlined", "char")
        ) format "x(40)".
