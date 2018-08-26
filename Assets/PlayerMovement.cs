using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour {
    Vector3 pos;
    float speed;
    public GameObject maincamera;
    float dissolveValue;
    public GameObject mirror;
    Renderer mat;
	// Use this for initialization
	void Start () {
        speed = 5.0f;
        mat = mirror.GetComponent<Renderer>();
        dissolveValue = 1.0f;
	}
	
	// Update is called once per frame
	void Update () {
        pos = transform.position;
        if (Input.GetButton("Horizontal"))
        {
            pos.x += Input.GetAxisRaw("Horizontal") * speed*Time.deltaTime;
        }
        transform.position = pos;
        //BlockDetecion();
        MirrorAction();

	}


    bool BlockDetecion()
    {
        int layerMask =  1 << 9;
        RaycastHit hit;
        Vector3 dir;
        dir = transform.position - maincamera.transform.position;
        if(Physics.Raycast(maincamera.transform.position,dir,out hit, Mathf.Infinity, layerMask))
        {
            return true;
        }
        else { return false; }
    }

    void MirrorAction() {
        if (BlockDetecion())
        {
            if (dissolveValue > 0.3) {
                dissolveValue -= Time.deltaTime;
            }
            else { dissolveValue = 0.3f; }
            Debug.Log("--");
        }
        else
        {
            if (dissolveValue <= 1.0)
            {
                dissolveValue += Time.deltaTime;
            }
            else
            {
                dissolveValue = 1.0f;
            }
            Debug.Log("++");
        }
        mat.material.SetFloat("Vector1_6A13F3F1", dissolveValue);
    }
    

}
