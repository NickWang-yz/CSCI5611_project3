using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    // Start is called before the first frame update
    [Header("Camera Settings")]
    public float mouseSensitivity = 0.6f;
    Vector3 defaultCamPos;
    Quaternion defaultCamRot;
    Vector2 mouseRot;

    bool setup = true;

    void Start()
    {
        mouseRot = new Vector2(180, 0);
    }

    // Update is called once per frame
    void Update()
    {
        // move camera with WASD
        if (Input.GetKey(KeyCode.W))
        {
            Camera.main.transform.Translate(new Vector3(0, 10.0f * Time.deltaTime, 0));
        }
        if (Input.GetKey(KeyCode.A))
        {
            Camera.main.transform.Translate(new Vector3(-10.0f * Time.deltaTime, 0, 0));
        }
        if (Input.GetKey(KeyCode.S))
        {
            Camera.main.transform.Translate(new Vector3(0, -10.0f * Time.deltaTime, 0));
        }
        if (Input.GetKey(KeyCode.D))
        {
            Camera.main.transform.Translate(new Vector3(10.0f * Time.deltaTime, 0, 0));
        }

        // rotate camera with right click
        if (Input.GetMouseButton(1))
        {
            mouseRot.x += Input.GetAxis("Mouse X") * mouseSensitivity;
            mouseRot.y += Input.GetAxis("Mouse Y") * mouseSensitivity;
            Camera.main.transform.localRotation = Quaternion.Euler(-mouseRot.y, mouseRot.x, 0);
        }


        // zoom in/out with mouse wheel
        if (Input.GetAxis("Mouse ScrollWheel") > 0)
        {
            Camera.main.fieldOfView--;
        }
        if (Input.GetAxis("Mouse ScrollWheel") < 0)
        {
            Camera.main.fieldOfView++;
        }
    }
}
