// リストに追加する
function addPlace(name, lat, lng){
    var li = $('<li>', {
        text: name,
        "class": "list-group-item"
    });
    li.attr("data-lat", lat);
    li.attr("data-lng", lng);

    // 重複チェックしてリストに追加
    if(!isExistList(li)) {
        $('#route-list').append(li);
    }
}
// リストの重複をチェックする
function isExistList(li) {
    var exist = false;
    $('#route-list li').each(function() {
        if($(this).text() == $(li).text()) {
            exist = true;
        }
    })
    return exist;
}

var rendererOptions = {
    suppressMarkers : true
}

// 複数地点のルートを検索する
function search() {
    var points = $('#route-list li');

    // 2地点以上のとき
    if (points.length >= 2){
        var origin; // 開始地点
        var destination; // 終了地点
        var waypoints = []; // 経由地点

        // origin, destination, waypointsを設定する
        for (var i = 0; i < points.length; i++) {
            points[i] = new google.maps.LatLng($(points[i]).attr("data-lat"), $(points[i]).attr("data-lng"));
            if (i == 0){
                origin = points[i];
            } else if (i == points.length-1){
                destination = points[i];
            } else {
                waypoints.push({ location: points[i], stopover: true });
            }
        }
        // リクエスト作成
        var request = {
            origin: origin,
            destination: destination,
            waypoints: waypoints,
            travelMode: google.maps.TravelMode.DRIVING
        };
        // ルートサービスのリクエスト
        new google.maps.DirectionsService().route(request, function(response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                // 結果を表示する
                new google.maps.DirectionsRenderer().setDirections(response);
                var data = response.routes[0].legs;
                for (var i = 0; i < data.length; i++) {
                    console.log(data[i].distance.text);
                    console.log(data[i].duration.text);
                }
            }
        });
    }
}