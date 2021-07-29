 
 /*------------------------------------------------------------------------
    File        : DynArgs
    Purpose     : Extend Args
    Syntax      : 
    Description : Receive string of dynamic arguments
    Author(s)   : sga0778
    Created     : Tue Jul 27 11:42:19 EDT 2021
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.

block-level on error undo, throw.

class DynArgs: 

  define temp-table Args
    field TheName as character
    field TheValue as character
    field TheType as character.
    
  define public property NumberOfParameter as integer get. set.
  define public property TheArgs as character get. set.
  
  constructor public DynArgs ():
  end.
  
  //  A 5 as int, B 6 as int
  constructor public DynArgs (input A as character):
    
    define variable Iter as integer no-undo.
    define variable TheParameter as character no-undo.
        
    NumberOfParameter = num-entries(A, ",").
    TheArgs = A.
    
    do Iter = 1 to NumberOfParameter:
      
      TheParameter = trim(entry(Iter, A)). // Help with spacing issues
      
      message TheParameter.
      
      create Args.
      
      assign
      Args.TheName = entry(1, TheParameter, " ").
      Args.TheValue = entry(2, TheParameter, " ").
      Args.TheType = entry(4, TheParameter, " ").
      .
      
    end. // do
    //message "Done".
  end constructor.

  method public void ShowParameter():
    
    for each Args:
      display Args.
    end.
    
  end.
  
  method public character ByName (ValueName as character):
  
    find Args no-lock
    where Args.TheName = ValueName
    no-error.
    
    if available Args then return Args.TheValue.
    
    return ?.
    
  end.  // ByName
  
  method public character TheType (ValueName as character): 
    
    find Args no-lock
    where Args.TheName = ValueName
    no-error.
    
    if available Args then return Args.TheType.
    
    return ?.
    
  end. // TheType
  
  method public character SetParameter (VarName as character, VarValue as character, VarType as character):
    
    if varType = "char" then
      VarValue = S2U(VarValue).
      
    return VarName + " " + VarValue + " as " + VarType.
    
  end.
  
  // Encode strings with spaces to _ so they can be found or skipped over
  
  method public character S2U(cData as character):
    
    cData = replace(cData, " ", "_").
    return cData.
    
  end.
  
  // Remove the above _ with a S (space)
  
  method public character U2S (cData as character):
    
    cData = replace(cData, "_", " ").
    return cData.
    
  end.  
  
end class. // DynArgs


/* Test class

function Powers returns decimal(input Arg as character):
  
  define variable DynArg as DynArgs no-undo.
  define variable A as integer no-undo.
  define variable B as integer no-undo.
  
  DynArg = new DynArgs(Arg).
  
  assign
  A = integer(DynArg:ByName("A"))
  B = integer(DynArg:ByName("B"))
  .
  
  DynArg:ShowParameter().
  
  return exp(A,B).
  
end.

define variable D as DynArgs no-undo.

D = new DynArgs().

display Powers ("A 10 as int,B 2 as int").

display Powers(D:SetParameter("A", "10", "int") + "," + D:SetParameter("B", "2", "int")).

---

Strings as parameters

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

*/
