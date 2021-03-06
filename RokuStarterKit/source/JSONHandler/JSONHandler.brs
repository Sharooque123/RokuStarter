REM : **** This class contains all the business logic & code related to JSON Handling  ****

REM : **** This method converts a Bright Script Object into JSON String ****
function SimpleJSONBuilder(jsonArray as object) as string
    return SimpleJSONAssociativeArray(jsonArray)
end function

REM : **** This method converts a Bright Script Associative Array into JSON String ****
function SimpleJSONAssociativeArray(jsonArray as object) as string
    jsonString = "{"
    For Each key in jsonArray
        jsonString = jsonString + Chr(34) + key + Chr(34) + ":"
        value = jsonArray[key]
        if Type(value) = "roString" then
            jsonString = jsonString + Chr(34) + value + Chr(34)
        else if Type(value) = "String" then
            jsonString = jsonString + Chr(34) + value + Chr(34)
        else if Type(value) = "roInt" or Type(value) = "roFloat" then
            jsonString = jsonString + value.ToStr()
        else if Type(value) = "roInteger" then
            jsonString = jsonString + value.ToStr()
        else if Type(value) = "roBoolean" then
            jsonString = jsonString + IIf(value, "true", "false")
        else if Type(value) = "roArray" then
            jsonString = jsonString + SimpleJSONArray(value)
        else if Type(value) = "roAssociativeArray" then
            jsonString = jsonString + SimpleJSONBuilder(value)
        end if
        jsonString = jsonString + ","
    next
    if Right(jsonString, 1) = "," then
        jsonString = Left(jsonString, Len(jsonString) - 1)
    end if

    jsonString = jsonString + "}"
    return jsonString
end function

REM : **** This method converts a Bright Script roArray into JSON String ****
function SimpleJSONArray(jsonArray as object) as string
    jsonString = "["

    For Each value in jsonArray
        if Type(value) = "roString" then
            jsonString = jsonString + Chr(34) + value + Chr(34)
        else if Type(value) = "roInt" or Type(value) = "roFloat" then
            jsonString = jsonString + value.ToStr()
        else if Type(value) = "roBoolean" then
            jsonString = jsonString + IIf(value, "true", "false")
        else if Type(value) = "roArray" then
            jsonString = jsonString + SimpleJSONArray(value)
        else if Type(value) = "roAssociativeArray" then
            jsonString = jsonString + SimpleJSONAssociativeArray(value)
        end if
        jsonString = jsonString + ","
    next
    if Right(jsonString, 1) = "," then
        jsonString = Left(jsonString, Len(jsonString) - 1)
    end if

    jsonString = jsonString + "]"
    return jsonString
end function

REM : **** This method performs some condition matching ****
function IIf(Condition, Result1, Result2)
    if Condition then
        return Result1
    else
        return Result2
    end if
end function