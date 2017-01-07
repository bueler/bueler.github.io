
//for boxes of the same width to be put in colloms of a length that is approriete
//id of elements is p1, p2, p3, ect.
//Its a mess of weights and numbers. just try stuff or ask me (Thomas)

window.onload = function (evt) {
    var post = [], i, id;
    for(i = 1; i < 1000; i++) {
        id = 'p' + i;
        if(document.getElementById(id)===false){
            break;
        }
        post[i]=document.getElementById(id);
    }
    Array.prototype.min = function() {
      return Math.min.apply(null, this);
    };
    function style(sidebarChange){
        var clums = [],
            colls = Math.floor(window.innerWidth/430),
            width = window.innerWidth;
            if (width<=1100 || !sidebarChange){
                colls = Math.floor(width/305);
            }
        for(i = 0; i < colls; i++) {
            clums[i] = 10;
        }

        //get the sidebar to close when the window is less that 1100 px wide
        if (width<=1100 && sidebarChange){
            document.getElementById("checkBox").checked = false;
        }else if(sidebarChange) {
            document.getElementById("checkBox").checked = true;
        }

        var k, obj, collom,
            wW = width - 260;
            if (width<=1100 || !sidebarChange){
                wW = width-40;
                document.getElementById("m").style.left = 20+'px'
                document.getElementById("m").style.width = wW+'px'
                document.getElementById("n").style.left = 10+'px'
            } else{
                document.getElementById("m").style.left = 230+'px'
                document.getElementById("m").style.width = wW+'px'
                document.getElementById("n").style.left = 220+'px'
            }
        for(i = 1; i <post.length+1; i++) {
            id = 'p' + i;
            k = clums.indexOf(clums.min());
            obj = document.getElementById(id).style;
            obj.position = "absolute";
            obj.top = clums[k] + 'px';
            obj.width = (wW-25*colls)/colls + 'px';
            obj.left = (wW/colls)*k + 20 +'px';
            clums[k] += post[i].offsetHeight + 20;
        }
    }
    $(window).resize(function(){
        style(true);
    });
    $("#checkBox").change(function() {
        if(!(this.checked)) {
            style(false);
        }
    });
    style(true);
};
