# tf-3tier

## working...
3티어

- [X] alb + auto scaling
-  [X] autoscaling policy + predictive
-  [X] stress -> alb 이벤트
-  [X] nlb + auto scaling
-  [X] stress -> nlb 이벤트
-  [ ] on-demand video
-  [ ] cloudwatch SNS (scaling policy에 대한) 
-  [ ] mongodb pss
-  [ ] EC2 -> EIP
-  [ ] alb -> Route53 + 가비아
-  [ ] DB 보안?
-  [ ] `.tfstate` -> S3에 남기기
-  [X] 모듈화
-  [ ] 인스턴스들 구체적인 스펙에 대한 이유 생각
-  [ ] codecommit 연동

## learned
1. region별/AZ별 지원되는 리소스의 종류 다르다 $\to$ 구현 전 확실히 고려할 것

## trouble shooting
1. autoscaling group $\to$ unhealthy 이슈, 결국 health checkf를 ELB 에서 EC2로 변경해서 해결 성공(몇 없는 자료 무작정 따라해서 문제 생김, 운좋게 해외 사이트에서 찾아서 해결)