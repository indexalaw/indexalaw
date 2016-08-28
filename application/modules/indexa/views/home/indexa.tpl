{{extends file="../template/layout.tpl"}}

{{block name= title}}
	Indonesia Index Application Law
{{/block}}

{{block name=addoncss}}
  <link type='text/css' rel='stylesheet' href='https://api.tiles.mapbox.com/mapbox.js/v2.2.4/mapbox.css'/>
  <link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/MarkerCluster.css' rel='stylesheet' />
  <link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/MarkerCluster.Default.css' rel='stylesheet' />
  <link type='text/css' rel='stylesheet' href='https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/MarkerCluster.css' />
  <link type='text/css' rel='stylesheet' href='https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/MarkerCluster.Default.css' />
  <link rel='stylesheet' type='text/css' href='https://fonts.googleapis.com/css?family=Raleway:500,600,700,800,900,400,300'>
  <link rel='stylesheet' type='text/css' href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,900,300italic,400italic'>
  <!-- Owl Carousel Assets -->
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/vendors/owl_carousel/css/owl.carousel.css')}}">
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/vendors/owl_carousel/css/owl.theme.css')}}">
  <!-- Pixeden Icon Font -->
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/vendors/pe_icon_7_stroke/Pe-icon-7-stroke.css')}}">
  <!-- PrettyPhoto -->
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/vendors/pretty_photo/prettyPhoto.css')}}">
  <!-- Style -->
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/vendors/template/css/style.css')}}">
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/vendors/animate/animate.css')}}">
  <!-- Responsive CSS -->
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/vendors/template/css/responsive.css')}}">
  <link rel='stylesheet' type='text/css' href="{{base_url('assets/frontend/css/guardian.css')}}">
{{/block}}

{{block name= stylecss}}
  <style type="text/css" media="screen">
    .map { 
      height: 600px;
      width:100%;
      border-top:3px solid gray; 
      border-bottom:3px solid gray; 
    }
    .search-ui {
      position:absolute;
      top:10px;
      right:10px;
      z-index:1000;
    }
  </style>
{{/block}}

{{block name= content}}

	<!-- PRELOADER -->
    <div class="spn_hol">
        <div class="spinner">
            <div class="bounce1"></div>
            <div class="bounce2"></div>
            <div class="bounce3"></div>
        </div>
    </div>
 <!-- END PRELOADER -->
 {{include "./header.tpl"}}
 {{include "./about_us.tpl"}}
 {{include "./services.tpl"}}
 {{include "./map.tpl"}}
 {{include "./api.tpl"}}
 {{include "./contact.tpl"}}
 {{include "./footer.tpl"}}
{{/block}}

{{block name=footer}}

{{/block}}

{{block name=addonjs}}
  <script type="text/javascript" src='https://api.tiles.mapbox.com/mapbox.js/v2.2.4/mapbox.js'></script>
  <script type="text/javascript" src='https://api.tiles.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/leaflet.markercluster.js'></script>
  <script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-markercluster/v0.4.0/leaflet.markercluster.js'></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/owl.carousel.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/jquery.fitvids.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/smoothscroll.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/jquery.parallax-1.1.3.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/jquery.prettyPhoto.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/jquery.ajaxchimp.min.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/jquery.ajaxchimp.langs.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/wow.min.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/waypoints.min.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/jquery.counterup.min.js')}}"></script>
  <script src="{{base_url('assets/frontend/vendors/template/js/script.js')}}"></script>
{{/block}}

{{block name=scriptjs}}
  <script type="text/javascript" charset="utf-8">
    $(document).mouseup(function (e){
        var container = $(".details-container");

        if (!container.is(e.target) // if the target of the click isn't the container...
            && container.has(e.target).length === 0) // ... nor a descendant of the container
        {
            container.hide();
            $(".details-container").unbind('click',document);
            $(".details-container-inner").remove();
        }
    });
    $('#search').keyup(search);
    L.mapbox.accessToken = 'pk.eyJ1IjoiYWd1bmdzdWthcm5vIiwiYSI6ImNpcjU1dXZrejAwMDZnY25mbDU5bG1pN2oifQ.F3KONJsQtx5rbMekfLdGZQ';

    var geojson = {{json_encode($geojson,JSON_NUMERIC_CHECK)}};
    // var markers = new L.MarkerClusterGroup();
    // var geoJsonLayer = L.geoJson(geojson);
    // var mapCluster = L.mapbox.map('map-one', 'agungsukarno.0pb6ddl7',{
    //                                                                     attributionControl: false,
    //                                                                     scrollWheelZoom: false,
    //                                                                     maxBounds: [[-6.389430, 106.836372],[-6.211298, 106.679816],[-6.055122, 106.824699],[-6.201058, 106.979880]],
    //                                                                     maxZoom: 19,
    //                                                                     minZoom: 11
    //                                                                  }).setView([-6.175182,106.827166], 11);

    // markers.addLayer(geoJsonLayer);
    // mapCluster.addLayer(markers);
    var map = L.mapbox.map('map-one', 'agungsukarno.0pb6ddl7',{
                                                                attributionControl: false,
                                                                scrollWheelZoom: false,
                                                                maxBounds: [[-6.389430, 106.836372],[-6.211298, 106.679816],[-6.055122, 106.824699],[-6.201058, 106.979880]],
                                                                maxZoom: 19,
                                                                minZoom: 11
                                                             }).setView([-6.175182,106.827166], 11);
    var markers = L.mapbox.featureLayer().setGeoJSON(geojson).addTo(map);
    markers.eachLayer(function(l){ 
        l.off('click');
        l.on('click', function(e) {
          var name              = l.feature.properties.name;
          var putusan           = l.feature.properties.putusan;
          var tahun             = l.feature.properties.tahun;
          var bulan             = l.feature.properties.bulan;
          var tgl               = l.feature.properties.tanggal;
          var hari              = l.feature.properties.hari;
          var kota              = l.feature.properties.kota;
          var kecamatan         = l.feature.properties.kecamatan;
          var kelurahan         = l.feature.properties.kelurahan;
          var jalan             = l.feature.properties.jalan;
          var rw                = l.feature.properties.rw;
          var rt                = l.feature.properties.rt;
          var rumah             = l.feature.properties.rumah;
          var pidana            = (l.feature.properties.tindak_pidana ? l.feature.properties.tindak_pidana : "-");
          var korban            = (l.feature.properties.korban ? l.feature.properties.korban : "-");
          var barang            = (l.feature.properties.barang ? l.feature.properties.barang : "-");
          var keterangan_tangkap= (l.feature.properties.keterangan_tangkap ? l.feature.properties.keterangan_tangkap : "-");

          var tempus = hari+" "+tgl+" "+bulan+" "+tahun;
          var locus  = jalan + " " + rumah + " " + rt + " " + rw + ", " + kelurahan + ", " + kecamatan + ", " + kota;

          var template_detail ='<div class="details-container-inner"> <div class="details no-image"> <div id="tempus" class="card-date">tempus</div><div id="nama_detail" class="name">nama terdakwa</div><div class="details-top"> <div class="image-container"> <div class="inner-image" style="background-image:url()"></div></div><div class="stats"> <div class="stat"> <div class="label">No Putusan</div><span id="putusan_detail" class="value">-</span> </div><div class="stat"> <div class="label">Tindak Pidana</div><span id="tindak_pidana" class="value">-</span> </div><div class="stat"> <div class="label">Lokasi kejadian</div><div id="locus" class="value">-</div></div><div class="stat"> <div class="stat-half"> <div class="label">Barang</div><div id="barang" class="value">-</div></div><div class="stat-half"> <div class="label">Korban</div><div id="korban" class="value">-</div></div></div><div class="stat"> <div class="label">Keterangan Tangkap</div><div id="tangkap" class="value">-</div></div></div></div></div></div>';
          $('#detail_value').html($(template_detail));
          $("#tempus").html(tempus);
          $("#locus").html(locus);
          $("#nama_detail").html(name);
          $("#putusan_detail").html(putusan);
          $("#tindak_pidana").html(pidana);
          $("#korban").html(korban);
          $("#barang").html(barang);
          $("#tangkap").html(keterangan_tangkap);
          $(".details-container").show();
        });
    });

    function search() {
    // get the value of the search input field
    // var searchString = $('#search').val().toLowerCase();

    markers.setFilter(findkecamatan);

    // here we're simply comparing the 'state' property of each marker
    // to the search string, seeing whether the former contains the latter.
    function findkecamatan(feature) {
        return feature.properties.kecamatan
            .toLowerCase()
            .indexOf(searchString) !== -1;
    }
}
  </script>
{{/block}}
