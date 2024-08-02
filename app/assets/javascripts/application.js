// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

let items = []
const ref = getCookie('savedlist')
if(ref != '') items = JSON.parse(ref)
document.cookie = "savedlist=" + JSON.stringify(items)

function getCookie(cookieName) {

    var name = cookieName + '='
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';')

    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1)
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length)
        }
    }

    return ''
}

function openNav() {
    if(window.innerWidth > 500) {
        document.getElementById("sidenav").style.width = "300px";
    } else {
        document.getElementById("sidenav").style.width = "100%";
    }
    document.getElementById("top-navigation").style.marginLeft = "250px";
}
  
function closeNav() {
    document.getElementById("sidenav").style.width = "0";
    document.getElementById("top-navigation").style.marginLeft= "0";
}

function savedList(item) {
    if(items.includes(item)) {
        items.splice(items.indexOf(item),1)
        document.getElementById('saved-item-'+item).remove()
    } else {
        items.push(item)
    }
    document.cookie = "savedlist=" + JSON.stringify(items)  + ";path=/"
}

function topBanner(item) {
    if(!items.includes(item)) {
        items.push(item)
    }
    console.log(JSON.stringify(items))
    document.cookie = "savedlist=" + JSON.stringify(items) + ";path=/"
}

var slideIndex = 0;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex + n);
}

function showDivs(n) {
  var x = document.getElementsByClassName("product-image")
  x[slideIndex].style.display = "none"

  if(n > x.length-1) n = 0;
  else if(n < 0) n = x.length-1;

  x[n].style.display = "block"
  
  slideIndex = n
}

function openFilters() {
    // console.log("OPEN SESAME")
    document.getElementById("filter-hidden").style.display = "block"
    document.getElementById("filter-button-open").style.display = "none"
}

var filters = []

function filter(filter) {
    if(filters.includes(filter)) {
        filters.remove(filter)
    } else {
        filters.push(filter)
    }
    console.log(filters)
}

function saveFilters() {
    var f = filters[0]
    for(var i = 1; i < filters.length; i++) {
        f += "&" + filters[i]
    }
    window.location.href =  "/collections?" + f
}