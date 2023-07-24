<?php
$conn = new mysqli("localhost", "root", "", "goals");

// Get all NFT data
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $query = "SELECT * FROM nft";
    $result = mysqli_query($conn, $query);

    $data = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = $row;
    }

    echo json_encode($data);
}
// Add new NFT data
elseif ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $art = isset($_POST['art']) ? $_POST['art'] : '';
    $path = isset($_POST['path']) ? $_POST['path'] : '';
    $nama = isset($_POST['nama']) ? $_POST['nama'] : '';
    $keterangan = isset($_POST['keterangan']) ? $_POST['keterangan'] : '';

    // Gunakan teknik sanitasi data, sesuai dengan kebutuhan, misalnya:
    // $art = mysqli_real_escape_string($conn, $art);
    // $path = mysqli_real_escape_string($conn, $path);
    // $nama = mysqli_real_escape_string($conn, $nama);
    // $keterangan = mysqli_real_escape_string($conn, $keterangan);

    $query = "INSERT INTO nft (art, path, nama, keterangan) VALUES ('$art', '$path', '$nama', '$keterangan')";
    $result = mysqli_query($conn, $query);

    if ($result) {
        $response = array("message" => "Data added successfully");
        echo json_encode($response);
    } else {
        $response = array("error" => "Failed to add data");
        echo json_encode($response);
    }
}
// Update existing NFT data
elseif ($_SERVER['REQUEST_METHOD'] == 'PUT') {
    parse_str(file_get_contents("php://input"), $data);

    $id = isset($data['id']) ? $data['id'] : '';
    $art = isset($data['art']) ? $data['art'] : '';
    $path = isset($data['path']) ? $data['path'] : '';
    $nama = isset($data['nama']) ? $data['nama'] : '';
    $keterangan = isset($data['keterangan']) ? $data['keterangan'] : '';

    // Gunakan teknik sanitasi data, sesuai dengan kebutuhan, misalnya:
    // $art = mysqli_real_escape_string($conn, $art);
    // $path = mysqli_real_escape_string($conn, $path);
    // $nama = mysqli_real_escape_string($conn, $nama);
    // $keterangan = mysqli_real_escape_string($conn, $keterangan);

    $query = "UPDATE nft SET art='$art', path='$path', nama='$nama', keterangan='$keterangan' WHERE id='$id'";
    $result = mysqli_query($conn, $query);

    if ($result) {
        $response = array("message" => "Data updated successfully");
        echo json_encode($response);
    } else {
        $response = array("error" => "Failed to update data");
        echo json_encode($response);
    }
}
// Delete existing NFT data
elseif ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
    parse_str(file_get_contents("php://input"), $data);

    $id = isset($data['id']) ? $data['id'] : '';

    $query = "DELETE FROM nft WHERE id='$id'";
    $result = mysqli_query($conn, $query);

    if ($result) {
        $response = array("message" => "Data deleted successfully");
        echo json_encode($response);
    } else {
        $response = array("error" => "Failed to delete data");
        echo json_encode($response);
    }
} else {
    $response = array("error" => "Invalid request method");
    echo json_encode($response);
}
?>