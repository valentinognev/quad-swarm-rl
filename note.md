# 复现笔记
## 配置
```sh
docker build -f docker/simulation.dockerfile -t quad_swarm_image:v0 --network=host --progress=plain .

# docker run --name quad-swarm -itd --privileged --gpus all --network=host \
#     -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
#     -v /home/dzp/projects/quad-swarm-rl:/workspace/quad-swarm-rl \
#     -e DISPLAY=$DISPLAY \
#     -e LOCAL_USER_ID="$(id -u)" \
#     quad_swarm_image:v0 /bin/bash

sudo docker run --name quad-swarm -itd --privileged --gpus all --network=host \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/ubuntu/dzp_is_sb/quad-swarm-rl:/workspace/quad-swarm-rl \
    -e DISPLAY=$DISPLAY \
    -e LOCAL_USER_ID="$(id -u)" \
    quad_swarm_image:v0 /bin/bash

docker exec -it quad-swarm /bin/bash

cd /workspace/quad-swarm-rl

python3 -m pip install -e .

python3 -m swarm_rl.train \
--env=quadrotor_multi --train_for_env_steps=1000000000 --algo=APPO --use_rnn=False \
--num_workers=4 --num_envs_per_worker=4 --learning_rate=0.0001 --ppo_clip_value=5.0 --recurrence=1 \
--nonlinearity=tanh --actor_critic_share_weights=False --policy_initialization=xavier_uniform \
--adaptive_stddev=False --with_vtrace=False --max_policy_lag=100000000 --rnn_size=256 \
--gae_lambda=1.00 --max_grad_norm=5.0 --exploration_loss_coeff=0.0 --rollout=128 --batch_size=1024 \
--with_pbt=False --normalize_input=False --normalize_returns=False --reward_clip=10 \
--quads_use_numba=True --save_milestones_sec=3600 --anneal_collision_steps=300000000 \
--replay_buffer_sample_prob=0.75 \
--quads_mode=mix --quads_episode_duration=15.0 \
--quads_obs_repr=xyz_vxyz_R_omega \
--quads_neighbor_hidden_size=256 --quads_neighbor_obs_type=pos_vel --quads_collision_hitbox_radius=2.0 \
--quads_collision_falloff_radius=4.0 --quads_collision_reward=5.0 --quads_collision_smooth_max_penalty=10.0 \
--quads_neighbor_encoder_type=attention --quads_neighbor_visible_num=6 \
--quads_use_obstacles=False --quads_use_downwash=True \
--experiment=test_multi_drone

python3 -m swarm_rl.enjoy --algo=APPO --env=quadrotor_multi --replay_buffer_sample_prob=0 --quads_use_numba=False --quads_render=True --train_dir=PATH_TO_TRAIN_DIR --experiment=EXPERIMENT_NAME --quads_view_mode CAMERA_VIEWS
```