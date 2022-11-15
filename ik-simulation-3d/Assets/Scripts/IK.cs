using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IK : MonoBehaviour
{
    // Start is called before the first frame update
    //public Vector3 root = new Vector3(0f, 5f, 0f);
    public GameObject rootJointObj;
    public GameObject elbowJointObj;
    public GameObject wristJointObj;
    public GameObject fingerJointObj;
    public GameObject endEffectorObj;
    public GameObject goal;
    public float rotationSpeed = 10f;


    void Start()
    {
        
    }

    void Solve()
    {
        Vector3 goalPos = goal.transform.position;
        Vector3 endPos = endEffectorObj.transform.position;
        float step = rotationSpeed * Time.deltaTime;

        Vector3 euler;
        float x, y, z;

        Vector3 fingerPos = fingerJointObj.transform.position;
        Quaternion fingerRot = fingerJointObj.transform.rotation;
        Vector3 startToGoal = (goalPos - fingerPos).normalized;
        Vector3 startToEnd = (endPos - fingerPos).normalized;
        Quaternion newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * fingerRot;
        euler = newRotation.eulerAngles;
        if (euler.x > 180) euler.x -= 360;
        if (euler.z > 180) euler.z -= 360;
        x = Mathf.Clamp(euler.x, -45, 45);
        z = Mathf.Clamp(euler.z, -90, 90);
        newRotation = Quaternion.Euler(x, 0, z);
        Quaternion rotateTowards = Quaternion.RotateTowards(fingerRot, newRotation, step);
        fingerJointObj.transform.rotation = rotateTowards;

        goalPos = goal.transform.position;
        endPos = endEffectorObj.transform.position;
        Vector3 wristPos = wristJointObj.transform.position;
        Quaternion wristRot = wristJointObj.transform.rotation;
        startToGoal = (goalPos - wristPos).normalized;
        startToEnd = (endPos - wristPos).normalized;
        newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * wristRot;
        euler = newRotation.eulerAngles;
        if (euler.x > 180) euler.x -= 360;
        if (euler.y > 180) euler.y -= 360;
        if (euler.z > 180) euler.z -= 360;
        x = Mathf.Clamp(euler.x, -90, 90);
        y = Mathf.Clamp(euler.y, 0, 180);
        z = Mathf.Clamp(euler.z, -90, 90);
        newRotation = Quaternion.Euler(x, y, z);
        wristJointObj.transform.rotation = Quaternion.RotateTowards(wristRot, newRotation, step);

        goalPos = goal.transform.position;
        endPos = endEffectorObj.transform.position;
        Vector3 elbowPos = elbowJointObj.transform.position;
        Quaternion elbowRot = elbowJointObj.transform.rotation;
        startToGoal = (goalPos - elbowPos).normalized;
        startToEnd = (endPos - elbowPos).normalized;
        newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * elbowRot;
        euler = newRotation.eulerAngles;
        if (euler.z > 180) euler.z -= 360;
        z = Mathf.Clamp(euler.z, -45, 120);
        newRotation = Quaternion.Euler(0, 0, z);
        rotateTowards = Quaternion.RotateTowards(elbowRot, newRotation, step);
        elbowJointObj.transform.rotation = rotateTowards;

        goalPos = goal.transform.position;
        endPos = endEffectorObj.transform.position;
        Vector3 rootPos = rootJointObj.transform.position;
        Quaternion rootRot = rootJointObj.transform.rotation;
        startToGoal = (goalPos - rootPos).normalized;
        startToEnd = (endPos - rootPos).normalized;
        newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * rootRot;
        euler = newRotation.eulerAngles;
        if (euler.x > 180) euler.x -= 360;
        if (euler.z > 180) euler.z -= 360;
        // Attempts to use angles between 0/360 (90, 270) vs (-90, 90) causes a gimbal lock?
        x = Mathf.Clamp(euler.x, -90, 90);
        z = Mathf.Clamp(euler.z, -90, 90);
        newRotation = Quaternion.Euler(x, 0, z);
        rotateTowards = Quaternion.RotateTowards(rootRot, newRotation, step);
        rootJointObj.transform.rotation = rotateTowards;
    }

    // Update is called once per frame
    void Update()
    {
        Solve();
    }
}
