<?php
$conn = new mysqli("localhost", "root", "", "goals");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $pengguna = isset($_POST['pengguna']) ? $_POST['pengguna'] : '';
    $token = isset($_POST['token']) ? $_POST['token'] : '';

    $query = "SELECT * FROM users WHERE pengguna='$pengguna' AND token='$token'";
    $result = mysqli_query($conn, $query);

    if (mysqli_num_rows($result) > 0) {
        $data = mysqli_fetch_array($result, MYSQLI_ASSOC);
        echo json_encode($data);
    } else {
        $response = array("error" => "Invalid credentials");
        echo json_encode($response);
    }
} else {
    $response = array("error" => "Invalid request method");
    echo json_encode($response);
}
?>