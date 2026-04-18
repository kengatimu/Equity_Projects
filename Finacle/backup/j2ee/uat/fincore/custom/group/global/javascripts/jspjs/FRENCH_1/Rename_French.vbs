Set objFso = CreateObject("Scripting.FileSystemObject")
Set Folder = objFSO.GetFolder("C:\Users\vishal.tripathi\Desktop\FRENCH_PROD\CUSTOM\FRENCH_1")

For Each File In Folder.Files
    sNewFile = File.Name
    sNewFile = Replace(sNewFile,"INFENG","FRENCH")
    if (sNewFile<>File.Name) then 
        File.Move(File.ParentFolder+"\"+sNewFile)
    end if

Next
