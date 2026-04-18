function enabledropdwn()
{
try
{

parent.parent.frames(0).formFilterFrame.FindForm.CREATE1.disabled= false;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE2.disabled= false;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE3.disabled= false;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE4.disabled= false;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE5.disabled= false;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE6.disabled= false;

								
}
catch(e){
alert(e.message);
}
}

function disabledropdwn()
{

try
{

parent.parent.frames(0).formFilterFrame.FindForm.CREATE1.disabled= true;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE2.disabled= true;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE3.disabled= true;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE4.disabled= true;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE5.disabled= true;
parent.parent.frames(0).formFilterFrame.FindForm.CREATE6.disabled= true;

								
}
catch(e){
alert(e.message);
}
}