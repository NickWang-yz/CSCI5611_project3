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

        Vector3 fingerPos = wristJointObj.transform.position;
        Quaternion fingerRot = wristJointObj.transform.rotation;
        Vector3 startToGoal = (goalPos - fingerPos).normalized;
        Vector3 startToEnd = (endPos - fingerPos).normalized;
        Quaternion newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * fingerRot;
        Quaternion rotateTowards = Quaternion.RotateTowards(fingerRot, newRotation, step);
        fingerJointObj.transform.rotation = rotateTowards;

        goalPos = goal.transform.position;
        endPos = endEffectorObj.transform.position;
        Vector3 wristPos = wristJointObj.transform.position;
        Quaternion wristRot = wristJointObj.transform.rotation;
        startToGoal = (goalPos - wristPos).normalized;
        startToEnd = (endPos - wristPos).normalized;
        newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * wristRot;
        wristJointObj.transform.rotation = Quaternion.RotateTowards(wristRot, newRotation, step);

        goalPos = goal.transform.position;
        endPos = endEffectorObj.transform.position;
        Vector3 elbowPos = elbowJointObj.transform.position;
        Quaternion elbowRot = elbowJointObj.transform.rotation;
        startToGoal = (goalPos - elbowPos).normalized;
        startToEnd = (endPos - elbowPos).normalized;
        newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * elbowRot;
        //Vector3 euler = newRotation.eulerAngles;
        //float x = Mathf.Clamp(euler.x, -150, 0);
        //newRotation = Quaternion.Euler(x, euler.y, 0);
        rotateTowards = Quaternion.RotateTowards(elbowRot, newRotation, step);
        elbowJointObj.transform.rotation = rotateTowards;

        goalPos = goal.transform.position;
        endPos = endEffectorObj.transform.position;
        Vector3 rootPos = rootJointObj.transform.position;
        Quaternion rootRot = rootJointObj.transform.rotation;
        startToGoal = (goalPos - rootPos).normalized;
        startToEnd = (endPos - rootPos).normalized;
        newRotation = Quaternion.FromToRotation(startToEnd, startToGoal) * rootRot;
        Vector3 euler = newRotation.eulerAngles;
        float x = Mathf.Clamp(euler.x, -90, 90);
        float z = Mathf.Clamp(euler.z, -90, 90);
        newRotation = Quaternion.Euler(x, euler.y, z);
        rotateTowards = Quaternion.RotateTowards(rootRot, newRotation, step);
        rootJointObj.transform.rotation = rotateTowards;
    }

    // Update is called once per frame
    void Update()
    {
        Solve();
    }
}
