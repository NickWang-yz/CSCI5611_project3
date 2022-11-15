using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoalController : MonoBehaviour
{
    // Start is called before the first frame update
    // Tutorial for dragging and moving the objects: https://www.patreon.com/posts/unity-3d-drag-22917454

    Vector3 mOffset;
    float mZCoord;

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {

    }

    Vector3 GetMouseAsWorldPoint()
    {
        Vector3 mousePoint = Input.mousePosition;
        mousePoint.z = mZCoord;
        return Camera.main.ScreenToWorldPoint(mousePoint);
    }

    private void OnMouseDown()
    {
        mZCoord = Camera.main.ScreenToWorldPoint(gameObject.transform.position).z;
        mOffset = gameObject.transform.position - GetMouseAsWorldPoint();
    }

    private void OnMouseDrag()
    {
        transform.position = GetMouseAsWorldPoint() + mOffset;
    }
}
