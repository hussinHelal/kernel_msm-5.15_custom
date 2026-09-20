// Add this wrapper function somewhere in the code
static ssize_t rtw_kernel_read(struct file *file, loff_t offset, char *buf, size_t len)
{
    mm_segment_t old_fs;
    ssize_t ret;
    
    old_fs = get_fs();
    set_fs(KERNEL_DS);
    ret = rtw_kernel_read(file, buf, len, &offset);
    set_fs(old_fs);
    
    return ret;
}
