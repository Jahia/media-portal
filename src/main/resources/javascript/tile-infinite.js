
//Anonymous function to get the state of the multiple ajax calls.
var MyRequestsCompleted = (function() {
    var numRequestToComplete,
        requestsCompleted,
        callBacks,
        singleCallBack;

    return function(options) {
        if (!options) options = {};

        numRequestToComplete = options.numRequest || 0;
        requestsCompleted = options.requestsCompleted || 0;
        callBacks = [];
        var fireCallbacks = function () {
            for (var i = 0; i < callBacks.length; i++) callBacks[i]();
        };
        if (options.singleCallback) callBacks.push(options.singleCallback);
        this.addCallbackToQueue = function(isComplete, callback) {
            if (isComplete) requestsCompleted++;
            if (callback) callBacks.push(callback);
            if (requestsCompleted == numRequestToComplete) fireCallbacks();
        };
        this.requestComplete = function(isComplete) {
            if (isComplete) requestsCompleted++;
            if (requestsCompleted == numRequestToComplete) fireCallbacks();
        };
        this.setCallback = function(callback) {
            callBacks.push(callBack);
        };
    };
})();

//Create an array with the path/url from the items of the list
//Then append the result HTML from each url, from a start-end using an offset
function getNext(start, load, $containerElement, initialElements){
    var end = start + load;
    var $content = $();
    var temp = "";
    var _numRequest = ((itemsLeft < load) ? itemsLeft : load);
    var total = initialElements+url.length;
    //Check if our array length is greater than the next index
    for (i = start; i < end; i++) {
        if (i < total) {
            $.ajax({
                type: "GET",
                url: url[i-initialElements],
                async: true,
                success: function (content) {
                    docLoading = true;
                    temp += content;
                    requestCallback.requestComplete(true);
                    //Increment for next begin (var start is global)
                    startItems = end;
                    //how many items left to render?
                    itemsLeft--;
                },
                error: function (ajaxContext) {
                    console.log("Error getting the next item at the url: "+url[i])
                    docLoading =true;
                }
            }).done(function() {
            });
        } else {
            docLoading = true;
        }
    }
    var requestCallback = new MyRequestsCompleted({
        numRequest: _numRequest,
        singleCallback: function(){
            $content = (temp);

            //Resize, fix for loaded images
            $containerElement.append( temp );
            //Fix for firefox
                $containerElement.justifiedGallery('norewind').on('jg.complete', function (e) {
                    docLoading = false;
                });

        }
    });

}

