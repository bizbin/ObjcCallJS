var JSPlugin = function(){
 return {
     JSPLUGIN_SCHEME : "feeyar",
     _consoleEl : null,
     _hiddenFrame: null,
    init : function () {
        _consoleEl = document.getElementById('consoleLog');
        
        JSPlugin.createIframeForCallObjc();
        
        _consoleEl.innerText = 'JSPlugin initialized!'
    },
    
    createIframeForCallObjc : function () {
        _hiddenFrame = document.createElement("iframe");
        _hiddenFrame.style.display = 'none';
        document.documentElement.appendChild(_hiddenFrame);
    },
     
     callObjcFun : function (funName, args) {
         _hiddenFrame.src = JSPlugin.JSPLUGIN_SCHEME + "://" + funName;
         //alert(_hiddenFrame.src);
         //if (!(args is Array)) throw new Error("");
         _hiddenFrame.dataset['args'] = JSON.stringify(args);
     },
     
     getJSData : function () {
         return _hiddenFrame.dataset['args']||"test";
     }
 };
}();