<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Indexa extends CI_Controller {

	private $data;

	function __construct(){

		parent::__construct();
		$this->data['display_navbar'] = FALSE;
		$this->parser->setModule("indexa");
	}

	public function index(){

		$geojson = array( 'type' => 'FeatureCollection', 'features' => array());
		
		$query = "SELECT 	 	DISTINCT a.no_putusan, GROUP_CONCAT(b.nama) as nama, b.keterangan_tangkap, c.marker_color, c.kota, 
												c.kecamatan, c.kelurahan, c.jalan, c.rw, c.rt, c.no_rumah, c.latitude, c.longitude, d.tahun, d.bulan, 
        							 	d.tanggal, d.hari, d.jam, e.tindak_pidana, e.korban, e.barang 
							FROM 		 	m_putusan a JOIN m_terdakwa b ON a.id = b.m_putusan_id 
											 	JOIN m_locus c ON a.id = c.m_putusan_id JOIN m_tempus d ON a.id = d.m_putusan_id 
        							 	JOIN m_tindak_pidana e ON a.id = e.m_putusan_id
        			GROUP BY 	a.no_putusan,b.keterangan_tangkap, c.kota, c.kecamatan, c.kelurahan, c.jalan, c.rw, c.rt, c.marker_color,
				 							 	c.no_rumah, c.latitude, c.longitude, d.tahun, d.bulan, d.tanggal, d.hari, d.jam, e.tindak_pidana, 
                 				e.korban, e.barang";
		$result = $this->db->query($query);

		foreach ($result->result() as $row) {
			$marker = array(
	                    'type' => 'Feature',
	                    'features' => array(
	                        'type' => 'Feature',
	                        'properties' => array(
	                            'putusan' 					 => $row->no_putusan,
	                            'name'							 => $row->nama,
	                            'keterangan_tangkap' => $row->keterangan_tangkap,
	                            'kota'							 => $row->kota,
	                            'kecamatan'					 => $row->kecamatan,
	                            'kelurahan'					 => $row->kelurahan,
	                            'jalan'							 => $row->jalan,
	                            'rw'					  		 => $row->rw,
	                            'rt'					  		 => $row->rt,
	                            'rumah'							 => $row->no_rumah,
	                            'tahun'							 => $row->tahun,
	                            'bulan'							 => $row->bulan,
	                            'tanggal'						 => $row->tanggal,
	                            'hari'							 => $row->hari,
	                            'tindak_pidana'			 => $row->tindak_pidana,
	                            'korban'						 => $row->korban,
	                            'barang'						 => $row->barang,
	                            "marker-color"			 => "#CE3D23",
									          	"marker-size"				 => "small",
									          	"marker-symbol"			 => "circle-stroked"
	                            ),
	                        "geometry" => array(
	                            'type' => 'Point',
	                            'coordinates' => array($row->longitude,$row->latitude)
	                        )
	                    )
	        					);

			array_push($geojson['features'], $marker['features']);
		}
		$this->data['geojson'] = $geojson;
		$this->parser->parse('home/indexa',$this->data);
	}

	public function insert(){

		$path = base_url("assets/frontend/docs/migrasi.csv");
		echo "<PRE>";
		// print_r($this->system->get_content($path));
		$file = fopen($path,0,"r");
		while(! feof($file)){

			$arrayfile = fgetcsv($file);
 			$information = array();
  		$information['no_putusan'] 		 		 = $arrayfile[0];
  		$information['terdakwa'] 			 		 = explode("|", $arrayfile[1]);
  		$information['tempus_thn'] 		 		 = $arrayfile[2];
  		$information['tempus_bln'] 		 		 = $arrayfile[3];
  		$information['tempus_tgl'] 		 		 = $arrayfile[4];
  		$information['tempus_hari']		 		 = $arrayfile[5];
  		$information['tempus_jam'] 		 		 = $arrayfile[6];
  		$information['locus_kota'] 		 		 = $arrayfile[7];
  		$information['locus_kecamatan'] 	 = $arrayfile[8];
  		$information['locus_kelurahan'] 	 = $arrayfile[9];
  		$information['locus_jln'] 			 	 = $arrayfile[10];
  		$information['locus_rw'] 			 		 = $arrayfile[11];
  		$information['locus_rt'] 			 		 = $arrayfile[12];
  		$information['locus_rmh'] 			 	 = $arrayfile[13];
  		$information['tindakan_brg'] 	 		 = $arrayfile[14];
  		$information['tindakan_pidana'] 	 = $arrayfile[15];
  		$information['tindakan_korban']    = $arrayfile[16];
  		$information['tindakan_tangkap'] 	 = $arrayfile[17];
  		$information['latitude'] 	 				 = $arrayfile[18];
  		$information['longitude'] 	 			 = $arrayfile[19];

  		$m_putusan = array('no_putusan' => $information['no_putusan']);	
			$this->db->insert('m_putusan', $m_putusan);

			$this->db->select("id");
			$this->db->from("m_putusan");
			$this->db->where("no_putusan",$information['no_putusan']);
			$putusan = $this->db->get();

			$putusan_id = $putusan->row("id");

			foreach ($information['terdakwa'] as $key => $value) {

				$nama = $value;
				$m_terdakwa = array('m_putusan_id' => $putusan_id, 'nama' => $nama, 'keterangan_tangkap' => $information['tindakan_tangkap']);	
				$this->db->insert('m_terdakwa', $m_terdakwa);
			}

			$m_tempus = array('m_putusan_id' => $putusan_id, 
												'tahun' => $information['tempus_thn'], 
												'bulan' => $information['tempus_bln'], 
												'tanggal' => $information['tempus_tgl'],
												'hari' => $information['tempus_hari'],
												'jam' => $information['tempus_jam']
												);	
			$this->db->insert('m_tempus', $m_tempus);

			$m_locus = array('m_putusan_id' => $putusan_id,
											 'kota' => $information['locus_kota'], 
											 'kecamatan' => $information['locus_kecamatan'], 
											 'kelurahan' => $information['locus_kelurahan'],
											 'jalan' => $information['locus_jln'],
											 'rw' => $information['locus_rw'],
											 'rt' => $information['locus_rt'],
											 'no_rumah' => $information['locus_rmh'],
											 'latitude' => $information['latitude'],
											 'longitude' => $information['longitude']
											);
			$this->db->insert('m_locus', $m_locus);

			$m_tindak_pidana = array('m_putusan_id' => $putusan_id, 
															 'tindak_pidana' => $information['tindakan_pidana'], 
															 'korban' => $information['tindakan_korban'], 
															 'barang' => $information['tindakan_brg']
															);	
			$this->db->insert('m_tindak_pidana', $m_tindak_pidana);
  		
  	}
		fclose($file);
	}

	public function grab_variables(){

		$variables = array('nama lengkap','tempat lahir','umur/tanggal lahir',
											 'jenis kelamin','kebangsaan','tempat tinggal','agama',
											 'pekerjaan','pendidikan');
		$grab = array();

		$this->db->db_select('indexa');
		$this->db->select('id,content');
		$this->db->from("t_m_raw_content");
		$result = $this->db->get();

		foreach($result->result() as $row) {
			$putusan = explode(PHP_EOL,$row->content);


			foreach ($putusan as $key => $sentence) {
				if(preg_match('/^(nomor\s?:|no.)/i', $sentence)){
					$no = $sentence;
					break;
				}
			}

			foreach ($variables as $varkey => $variable) {
				foreach ($putusan as $key => $sentence) {

					$cleanvar = str_replace("/", "\/", $variable);
					if(preg_match('/^'.$cleanvar.'\s?:/i', $sentence)){
						$grab[$no][$variable] = substr($sentence, strpos($sentence,":")+1);
						break;
					}
				}
			}
		}

		$this->data['variables'] = $grab;
		$this->parser->parse('script/grab_variable',$this->data);
	}

	public function excel(){

		$variables = array('nama lengkap','tempat lahir','umur/tanggal lahir',
											 'jenis kelamin','kebangsaan','tempat tinggal','agama',
											 'pekerjaan','pendidikan');
		$grab = array();

		$this->db->db_select('indexa');
		$this->db->select('id,content');
		$this->db->from("t_m_raw_content");
		$result = $this->db->get();

		// NAMA HEADER
		$grab[0]['putusan'] = 'Putusan';
		foreach($variables as $key => $value) {
			$grab[0][$value] = ucwords($value);
		}

		// ISI EXCEL
		$nomor = 1;
		foreach($result->result() as $row) {
			$putusan = explode(PHP_EOL,$row->content);


			foreach ($putusan as $key => $sentence) {
				if(preg_match('/^(nomor\s?:|no.)/i', $sentence)){
					$no = $sentence;
					break;
				}
			}

			foreach ($variables as $varkey => $variable) {

				$flag = 0;
				$grab[$nomor]['putusan'] = $no;

				foreach ($putusan as $key => $sentence) {

					$cleanvar = str_replace("/", "\/", $variable);
					if(preg_match('/^'.$cleanvar.'\s?:/i', $sentence)){
						$flag = 1;
						$grab[$nomor][$variable] = trim(substr($sentence, strpos($sentence,":")+1),";.");
						break;
					}
				}
				if($flag == 0){
					$grab[$nomor][$variable] = "";
				}
			}
			$nomor++;
		}

		//load our new PHPExcel library
    $this->load->library('excel');
    //activate worksheet number 1
    $this->excel->setActiveSheetIndex(0);
    //name the worksheet
    $this->excel->getActiveSheet()->setTitle('Variables');

    // read data to active sheet
    
    $this->excel->getActiveSheet()->fromArray($variables);
    $this->excel->getActiveSheet()->fromArray($grab);

    $filename='indexalaw_variables.xls'; //save our workbook as this file name

    header('Content-Type: application/vnd.ms-excel'); //mime type

    header('Content-Disposition: attachment;filename="'.$filename.'"'); //tell browser what's the file name

    header('Cache-Control: max-age=0'); //no cache
                
    //save it to Excel5 format (excel 2003 .XLS file), change this to 'Excel2007' (and adjust the filename extension, also the header mime type)
    //if you want to save it as .XLSX Excel 2007 format

    $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');

    //force user to download the Excel file without writing it to server's HD
    $objWriter->save('php://output');
	}

}
