# Scala Setting

## repository

`$HOME/.sbt/repositories`
```
[repositories]
    local
    myNexus: http://xxxxxxxxxxx
    aliyun: http://maven.aliyun.com/nexus/content/groups/public/
```

### credentials

`~/.sbt/.credentials.${realm}`
```
realm=some repo real
host=repo.example.com
user=artifactory-user
password=P4ssw0rdH4sh
```

`～/.sbt/$sbt_version/plugins/credentials.sbt`
```
credentials += Credentials(Path.userHome / ".sbt" / ".credentials.${realm}")
```

## proxy
`$HOME/.sbt/conf/sbtconfig.txt`
```
-Dhttp.proxyHost=127.0.0.1
-Dhttp.proxyPort=12639
-Dhttps.proxyHost=127.0.0.1
-Dhttps.proxyPort=12639
```
