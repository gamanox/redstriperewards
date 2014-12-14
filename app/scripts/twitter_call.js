function get_short_url(long_url, login, api_key, func)
{
    $.getJSON(
        "http://api.bitly.com/v3/shorten?callback=?", 
        { 
            "format": "json",
            "apiKey": api_key,
            "login": login,
            "longUrl": long_url
        },
        function(response)
        {
            func(response.data.url);
        }
    );
}

var login = "o_2ah0i4qmjq";
var api_key = "R_6807ad8823cf45d680023b590c04956f";
var long_url = "http://www.kozlenko.info";

get_short_url(long_url, login, api_key, function(short_url) {
    console.log(short_url);
});