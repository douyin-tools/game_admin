<?php

namespace Admincenter\Model;

use Think\Model;

class SettingModel extends BaseModel {


    public function updateByName($name, $value)
    {
        return $this->where(['name' => $name])->save(['value' => $value]);
    }

}
