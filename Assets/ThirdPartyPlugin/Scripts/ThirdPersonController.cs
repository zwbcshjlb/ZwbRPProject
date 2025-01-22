using UnityEngine;

public class ThirdPersonController : MonoBehaviour
{
    [SerializeField]  private Transform followTarget;
    [SerializeField] private float rotationSpeed=2f;//旋转速度
    [SerializeField] private float distance=5;
 
    [SerializeField] private float minVerticalAngle = -45;
    [SerializeField] private float maxVerticalAngle = 45;
 
    [SerializeField] private Vector2 framingOffset;//偏移量
 
    float rotationX;
    float rotationY;
 
    private void Start()
    {
        if (!Input.GetKey(KeyCode.LeftAlt))
        {
            Cursor.visible = false;
            Cursor.lockState = CursorLockMode.Locked;
        }
    }
    private void Update()
    {
 
        rotationX += Input.GetAxis("Mouse Y") * -rotationSpeed;
        rotationX = Mathf.Clamp(rotationX, minVerticalAngle, maxVerticalAngle);
 
        rotationY += Input.GetAxis("Mouse X") * -rotationSpeed;
 
        var targetRotation = Quaternion.Euler(rotationX, rotationY, 0);
        var focusPostion = followTarget.position + new Vector3(framingOffset.x, framingOffset.y);
 
        transform.position = focusPostion - targetRotation * new Vector3(0, 0, distance);
        transform.rotation = targetRotation;
 
    }
}
