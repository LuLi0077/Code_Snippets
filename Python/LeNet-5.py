### Implement LeNet-5
# Conv2D wrapper, with bias and relu activation
def conv2d(x, W, b, strides):
    x = tf.nn.conv2d(x, W, strides=[1, strides, strides, 1], padding='VALID')
    x = tf.nn.bias_add(x, b)
    return tf.nn.relu(x)

# Max-pooling
def maxpool2d(x, k):
    return tf.nn.max_pool(x, ksize=[1, k, k, 1], strides=[1, k, k, 1], padding='VALID')

def LeNet(x):        
    # Layer 1
    conv1 = conv2d(x, tf.Variable(tf.truncated_normal(shape=(5, 5, 3, 6), mean = mu, stddev = sigma)), 
                   tf.Variable(tf.zeros(6)), strides)
    conv1 = maxpool2d(conv1, k)

    # Layer 2
    conv2 = conv2d(conv1, tf.Variable(tf.truncated_normal(shape=(5, 5, 6, 16), mean = mu, stddev = sigma)),
                   tf.Variable(tf.zeros(16)), strides)
    conv2 = maxpool2d(conv2, k)
    
    # Fully connected layer
    # Reshape conv3 output to fit fully connected layer input
    fc11 = flatten(conv2)
    fc11 = tf.add(tf.matmul(fc11, tf.Variable(tf.truncated_normal(shape=(400, 120), mean = mu, stddev = sigma))),
                            tf.Variable(tf.zeros(120)))
    fc11 = tf.nn.relu(fc11)
    
    # Fully connected layer
    fc12 = tf.add(tf.matmul(fc11, tf.Variable(tf.truncated_normal(shape=(120, 84), mean = mu, stddev = sigma))),
                            tf.Variable(tf.zeros(84)))
    fc12 = tf.nn.relu(fc12)

    # Output Layer - class prediction
    out = tf.add(tf.matmul(fc12, tf.Variable(tf.truncated_normal(shape=(84, 43), mean = mu, stddev = sigma))),
                           tf.Variable(tf.zeros(43)))
    return out