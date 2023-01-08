---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: phpmyadmin-deployment
  labels:
    app: phpmyadmin
spec:
  replicas: 1
  selector:
    matchLabels:
      app: phpmyadmin
  template:
    metadata:
      labels:
        app: phpmyadmin
    spec:
      containers:
        - name: phpmyadmin
          image: phpmyadmin/phpmyadmin
          ports:
            - containerPort: 80
          env:
           - name: PMA_HOST
             value: "c-${mysql-clu-id}.rw.mdb.yandexcloud.net" # mysql-service
           - name: PMA_PORT
             value: "3306"
#            - name: MYSQL_ROOT_PASSWORD
#              valueFrom:
#                secretKeyRef:
#                  name: mysql-secrets
#                  key: root-password

---
apiVersion: v1
kind: Service
metadata:
  name: phpmyadmin-service
spec:
  selector:
    app: phpmyadmin
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  # clusterIP: 10.0.171.239
  type: LoadBalancer
