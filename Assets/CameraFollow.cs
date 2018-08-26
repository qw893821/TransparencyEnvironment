using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour {
    GameObject player;
	// Use this for initialization
	void Start () {
        player = GameObject.Find("Cube");
	}
	
	// Update is called once per frame
	void Update () {
        Vector3 pos;
        pos = transform.position;
        pos.x = player.transform.position.x;
        transform.position = pos;
	}
}
