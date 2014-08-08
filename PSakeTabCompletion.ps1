Register-TabExpansion "build.ps1" -Type Command {
    param($Context, [ref]$TabExpansionHasOutput, [ref]$QuoteSpaces)
 
    $Argument = $Context.Argument
    $TabExpansionHasOutput.Value = $true

    #Find the build file, the $Context.Line is the full command entered
    $buildFile = $Context.Line -Replace ($Context.Command+".*"),$Context.Command
    
    #Call the build file with the -docs switch
    .$buildFile -docs | 
        #Grab the Task names
        %{if ($_.GetType().Name -eq 'FormatEntryData'){$_.formatEntryInfo.formatPropertyFieldList[0].propertyValue}} |
        #Filter on the argument entered
        where {$_ -like "$Argument*"} 
}