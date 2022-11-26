#!/bin/bash
PWD=$(pwd)
#当前时间
DATE=`date "+%Y-%m-%d %H:%M:%S"`
#发送人的邮箱
From_mail_name=xxx@qq.com
#收件人的邮箱（支持群发，一行一个邮箱）
To_mail_name=(
xxx@qq.com
)
#邮件内容的txt名字
mail_txt_name=mail.txt
#邮件的标题
mail_name=test
#邮件的内容（如果要群发的话在下面的”${mail_detail}“中修改）
mail_detail=test_detail
#邮箱的授权码（如qq邮箱，需要开启4个权限，然后点击获取授权码，然后填入这里）
Authorization_code=xxxx

cat << EOF > ${mail_txt_name}
From:${From_mail_name}
To:${To_mail_name}
Subject:${mail_name}

${mail_detail}
EOF

for To_mail_names in ${To_mail_name[@]} ; do
curl -s --url "smtp://smtp.qq.com" --mail-from "${From_mail_name}" --mail-rcpt "${To_mail_names}" --upload-file ./${mail_txt_name} --user "${From_mail_name}:${Authorization_code}"
echo "在${DATE}邮件已发送给${To_mail_names}!!"
echo "在${DATE}邮件已发送给${To_mail_names}!!" >> $(pwd)/mail.log
done

rm -f ${mail_txt_name}
